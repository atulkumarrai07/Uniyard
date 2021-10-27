

import SwiftUI

struct UniYardHomepage: View {
    var body: some View {
      NavigationView{
        ScrollView{
          VStack{
            Text("UniYard Homepage")
            HStack{
              NavigationLink("Items", destination: ItemHome(userId: "U00001")).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).frame(width: 150, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)))
            }
          }
        }
      }
    }
}

struct UniYardHomepage_Previews: PreviewProvider {
    static var previews: some View {
        UniYardHomepage()
    }
}