import SwiftUI
struct ChatView: View {
  var viaFlag:Bool
  @Environment(\.presentationMode) var chatPresentation: Binding<PresentationMode>
  var body: some View {
   NavigationView {
    ZStack{
     VStack{
     HStack {
        Button(action: {
          self.chatPresentation.wrappedValue.dismiss()
        })
        {
        Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
        }
        Text("Chats")
        .font(.largeTitle)
        .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        .fontWeight(.heavy)
        .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
       }
      Text("This is the chat view").bold()
      Spacer()
     }
    }.navigationBarHidden(true)
   }
  }
}
struct Chat_Previews: PreviewProvider {
  static var previews: some View {
    ChatView(viaFlag: false)
  }
}
