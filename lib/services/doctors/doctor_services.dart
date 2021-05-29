import 'dart:collection';

import 'package:clarity/model/dactor_model.dart';
import 'package:clarity/services/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:rxdart/rxdart.dart';

class DoctorServices {
  final PublishSubject<List<DoctorModel>> _doctorsListController =
      PublishSubject<List<DoctorModel>>();

  static final CollectionReference _doctorsCollection =
      kfirestore.collection("doctors");

  // List<DoctorModel> _doctorslist = [];

  // Stream<List<DoctorModel>> listenDoctorsList() {
  //   getDoctors();
  //   return _doctorsListController.stream;
  // }

  // Future<void> getDoctors() async {
  //   //todo remember to limit fetch GCP bill will be huge
  //   await _doctorsCollection.get().then(
  //     (value) {
  //       value.docs.forEach(
  //         (e) {
  //           var t = DoctorModel.fromJson(e.data());
  //           _doctorslist.add(t);
  //           cprint("doctor added to list");
  //         },
  //       );
  //       // return null;
  //     },
  //   );
  //   _doctorsListController.add(_doctorslist);
  //   cprint("${_doctorslist.length}  Number of doctors fetched from database");
  // }

  // final PublishSubject<List<DoctorModel>> postsController =
  //     PublishSubject<List<DoctorModel>>();
  // final PublishSubject<List<DoctorModel>> profileDataController =
  // PublishSubject<List<DoctorModel>>();

  // #6: Create a list that will keep the paged results
  List<List<DoctorModel>> _allPagedResults = [];
  List<DoctorModel> _feed = [];

  static const int PostsLimit = 10;

  DocumentSnapshot _lastDocument;
  // bool _hasMorePosts = true;
  List<DoctorModel> allPosts = [];
  // CollectionReference schoolRefs;

  Stream<List<DoctorModel>> listenDoctorsList() {
    _requestPosts();
    return _doctorsListController.stream;
  }

  // #1: Move the request feed into it's own function
  void _requestPosts() async {
    var _postRef = _doctorsCollection;
    // (await schoolRefwithCode()).doc('Posts').collection(stdDivGlobal);
    // #2: split the query from the actual subscription
    var doc = await _postRef.get();
    if (doc.docs.isNotEmpty) {
      var pagePostsQuery = _postRef
          // .orderBy('timeStamp', descending: true)
          // #3: Limit the amount of results
          .limit(PostsLimit);

      // #5: If we have a doc start the query after it
      if (_lastDocument != null) {
        pagePostsQuery = pagePostsQuery.startAfterDocument(_lastDocument);
      }

      // if (!_hasMorePosts) return;

      // #7: Get and store the page index that the results belong to
      var currentRequestIndex = _allPagedResults.length;

      pagePostsQuery.snapshots().listen(
        (postsSnapshot) {
          if (postsSnapshot.docs.isNotEmpty) {
            _feed = postsSnapshot.docs
                .map((snapshot) => DoctorModel.fromJson(snapshot.data()))
                // .where((mappedItem) => mappedItem.caption != null)
                .toList();
            // #8: Check if the page exists or not
            var pageExists = currentRequestIndex < _allPagedResults.length;

            // #9: If the page exists update the feed for that page
            if (pageExists) {
              _allPagedResults[currentRequestIndex] = _feed;
            }
            // #10: If the page doesn't exist add the page data
            else {
              _allPagedResults.add(_feed);
              cprint(
                  'the last room descr fetched ' +
                      _feed.last.description.toString(),
                  event: 'Last room descr fetched and entered into stream',
                  warningIn: 'This is the last available room localy');
            }

            // #11: Concatenate the full list to be shown
            allPosts = _allPagedResults.fold<List<DoctorModel>>([],
                (initialValue, pageItems) => initialValue..addAll(pageItems));

            // #12: Broadcase all feed
            _doctorsListController.add(UnmodifiableListView(allPosts));

            // #13: Save the last doc from the results only if it's the current last page
            if (currentRequestIndex == _allPagedResults.length - 1) {
              _lastDocument = postsSnapshot.docs.last;
            }

            // #14: Determine if there's more feed to request
            // _hasMorePosts = feed.length == PostsLimit;
          }
        },
      );
    } else
      cprint('No Class with this name yet', errorIn: 'No Data');
  }

  void requestMoreData() => _requestPosts();
}
