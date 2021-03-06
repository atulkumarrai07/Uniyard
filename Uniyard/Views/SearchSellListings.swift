import SwiftUI
import SDWebImageSwiftUI

struct SearchSellListings: View {
  @StateObject var itemViewModel:ItemsViewModel
    var body: some View {
        VStack{
          NavigationLink(
            destination: CreateSellView(),
            label: {
              Text("Post to Sell")
            }).frame(width: 350, height: 40, alignment: .center).foregroundColor(.white).background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.title).cornerRadius(15.0).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
          if(itemViewModel.filteredPosts.count < 1){
            VStack{
          Spacer()
            Text("No search results found!").font(.headline).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
          }
          }
          List(itemViewModel.filteredPosts, id: \.itemId){itemPostAvailable in
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
                      Text(String(itemPostAvailable.item_title)).font(.headline).foregroundColor(.black)
                    }.frame(width: 230, height: 15, alignment: .leading).padding(.bottom,0.1)
                    HStack{
                      Text("Condition: " + String(itemPostAvailable.condition)).font(.subheadline).foregroundColor(.black).opacity(0.8)
                    }.frame(width: 230, height: 15, alignment: .leading)
                    Spacer()
                    HStack{
                      Text("$ " + String(itemPostAvailable.price)).font(.subheadline).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
                      Spacer()
                      Text("5 minutes ago").foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).font(.subheadline)
                    }.frame(width: 230, height: 15, alignment: .leading)
                  }.padding(.vertical).frame(width: 240, height: 100, alignment: .leading)
                }.frame(width: 350, height: 110, alignment: .center).overlay(RoundedRectangle(cornerRadius: 14.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
              })
          }
          Spacer()
        }.navigationBarHidden(true)
    }
}

struct SearchSellListings_Previews: PreviewProvider {
    static var previews: some View {
      let itemViewModel = ItemsViewModel()
      SearchSellListings(itemViewModel: itemViewModel)
    }
}
