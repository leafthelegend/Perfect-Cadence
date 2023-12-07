import SwiftUI

struct ExamplesListView: View {
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    
    private let numOfItems: Int = 3 // change as adding more items
    private let itemWidth: CGFloat = 250 // how to set as adaptive
    private let peekAmount: CGFloat = -5
    private let dragThreshold: CGFloat = 100
    let items: [Image] = [
        Image("start_running"),
        Image("select_music"),
        Image("autoDJ")
    ]
    
    let texts: [Text] = [
        Text("Start Running!"),
        Text("Select Playlist"),
        Text("AutoDJ")
    ]
    
    let links: [AnyView] = [
        AnyView(PlayerScreen()),
        AnyView(DebugMenuView()),
        AnyView(SquigglyBobWrapper()),
//        PaceView(),
//        SearchForTracksView()
    ]
    
    
    var body: some View {
        GeometryReader {geometry in
            
            HStack (alignment: .center, spacing: peekAmount){
                ForEach(items.indices, id: \.self) { index in
                    
                    NavigationLink(
                        destination: AnyView(links[index]),
                        label: {
                            items[index]
                                .resizable()
                                .cornerRadius(25)
                                .frame(width: itemWidth,
                                       height: itemWidth)
                                .overlay(alignment: .bottomLeading) {
                                    texts[index]
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .offset(CGSize(
                                            width: 10,
                                            height: 40)
                                        )
                                        .opacity(self.textOpacity(at: index, in: geometry))
                                }
                                .scaleEffect(self.scaleValue(at: index, in: geometry))
                        }
                    )
                    
                }
                
            }
            .offset(x: calculateOffset() + dragOffset)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged{ value in
                        withAnimation(.interactiveSpring()) {
                            dragOffset = value.translation.width
                        }
                    }
                    .onEnded{ value in
                        withAnimation(.interactiveSpring()) {
                            finalisePosition(dragValue: value)
                            dragOffset = 0
                        }
                    }
            )
        }
    }
    
    
    func calculateOffset() -> CGFloat {
        let totalItemWidth = itemWidth + peekAmount
        return -CGFloat(currentIndex) * totalItemWidth
    }

    
    func scaleValue(at index: Int, in geometry: GeometryProxy) -> CGFloat {
        let itemPosition = CGFloat(index) * (itemWidth + peekAmount) + calculateOffset() + dragOffset
        let distanceFromCenter = abs(geometry.size.width / 2 - itemPosition - itemWidth / 2)
        let scale: CGFloat = 0.8 + (0.2 * (1 - min(1, distanceFromCenter / (itemWidth + peekAmount))))
        return scale
    }
    
    
    func textOpacity(at index: Int, in geometry: GeometryProxy) -> Double {
        let threshold: CGFloat = itemWidth / 2
        let itemPosition = CGFloat(index) * (itemWidth + peekAmount) + calculateOffset() + dragOffset + threshold
        let distanceFromCenter = abs(geometry.size.width / 2 - itemPosition)
        return Double(min(1, max(0, (threshold - distanceFromCenter) / threshold)))
    }
    
    
    func finalisePosition(dragValue: DragGesture.Value) {
        
        if dragValue.predictedEndTranslation.width > dragThreshold {
            if currentIndex > 0 {
                currentIndex -= 1
            } 
            else {
                currentIndex = numOfItems - 1
            }
        } else if dragValue .predictedEndTranslation.width < -dragThreshold {
            if currentIndex < numOfItems - 1 {
                currentIndex += 1
            } 
            else {
                currentIndex = 0
            }
        }
    }
}

struct ExamplesListView_Previews: PreviewProvider {
    
    static let spotify: Spotify = {
        let spotify = Spotify()
        spotify.isAuthorized = true
        return spotify
    }()
    
    static var previews: some View {
        NavigationView {
            ExamplesListView()
                .environmentObject(spotify)
        }
    }
}


