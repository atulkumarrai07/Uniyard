import SwiftUI
import SDWebImageSwiftUI

struct SavedPostView: View {
  @StateObject var savePostViewModel = SavedPostViewModel()
  @State var emptyCheck: Bool = false
  var body: some View {
    ZStack{
     VStack{
     HStack {
        Text("Saved Posts").font(.system(size: 30, weight: .heavy))
        .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        .frame(maxWidth: .infinity, alignment: .center)
       }
      if(savePostViewModel.isEmptySavePostList){
        VStack{
          Spacer()
        Text("No posts bookmarked yet!").font(.headline).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          Spacer()
        
      }
      }
      else{
      List(savePostViewModel.savedPostfilteredItems, id: \.itemId){itemPostAvailable in
        if(itemPostAvailable.item_buy)
        {
          NavigationLink(
            destination: ItemDetailsBuy(itemDetails: itemPostAvailable),
            label: {
              HStack{
                VStack(alignment: .leading){
                  HStack {
										Text("[Buy]").foregroundColor(.blue).font(.title3).frame( alignment: .leading)
                    Text(String(itemPostAvailable.item_title)).font(.headline).foregroundColor(.black)
                  }
//									.frame(width: 230, height: 15, alignment: .leading).padding(.bottom,0.1)

                  HStack{
                    Text("Category: " + String(itemPostAvailable.item_category)).font(.subheadline).foregroundColor(.black).opacity(0.8)
                  }
//									.frame(width: 230, height: 15, alignment: .leading)
                  Spacer()
                  HStack{
                    Text("$ " + String(itemPostAvailable.price)).font(.subheadline).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
                    Spacer()
										
										Text(convertTimestamp(serverTimestamp: itemPostAvailable.last_modified_timestamp))
											.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.subheadline)
                  }
//									.frame(width: 230, height: 15, alignment: .leading)
                }
								.padding()
//								.frame(width: 240, height: 100, alignment: .leading)
              }
							.frame(width: 350, height: 110, alignment: .center)
							.overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))

            })
        }
        else
        {
          NavigationLink(
            destination: ItemDetailsSell(itemDetails: itemPostAvailable),
            label: {
              HStack{
								VStack{
									if (itemPostAvailable.images.count > 0){
										WebImage(url: URL(string: itemPostAvailable.images[0]))
											.resizable().frame(width: 100, height: 100, alignment: .center)
											.cornerRadius(10)
									} else{
										Image("white_login_logo").resizable().frame(width: 100, height: 100, alignment: .center)
									}
								}.offset(CGSize(width: 7.0, height: 0))
								
                Spacer()
                VStack{
                  HStack {
										Text("[Sell]").foregroundColor(.blue).font(.title3).frame( alignment: .leading)
                    Text(String(itemPostAvailable.item_title)).font(.headline).foregroundColor(.black)
                  }.frame(width: 230, height: 15, alignment: .leading).padding(.bottom,0.1)
                  HStack{
                    Text("Category: " + String(itemPostAvailable.item_category)).font(.subheadline).foregroundColor(.black).opacity(0.8)
                  }.frame(width: 230, height: 15, alignment: .leading)
                  Spacer()
                  HStack{
                    Text("$ " + String(itemPostAvailable.price)).font(.subheadline).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
                    Spacer()
										
										Text(convertTimestamp(serverTimestamp: itemPostAvailable.last_modified_timestamp))
											.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.subheadline)
										
                  }.frame(width: 230, height: 15, alignment: .leading)
                }.padding(.vertical).frame(width: 240, height: 100, alignment: .leading)
              }.frame(width: 350, height: 110, alignment: .center).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
            })
        }
        
      }
      Spacer()
      }
     }
    }.navigationBarHidden(true)
    .onAppear{
      savePostViewModel.loadSavedPosts()
      }
    }
  }
struct SavedPost_Previews: PreviewProvider {
  static var previews: some View {
    SavedPostView()
  }
}
