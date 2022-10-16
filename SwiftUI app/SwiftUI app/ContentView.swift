//
//  ContentView.swift
//  SwiftUI app
//
//  Created by Nikita Lizogubov on 15.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var isShown = false
    @State var viewTranslation = CGSize.zero
    @State var isBottomCardShown = false
    @State var bottomCardTranslation = CGSize.zero
    @State var isBottomFullShown = false
    
    var body: some View {
        ZStack {
            TitleView()
                .opacity(isBottomCardShown ? 0.6 : 1.0)
                .animation(.default.delay(0.1), value: isBottomCardShown)
            BackCardView()
                .frame(width: isShown ? 375.0 : 340.0, height: 222.0)
                .background(Color.blue)
                .cornerRadius(20.0)
                .shadow(radius: 20.0)
                .offset(x: .zero, y: isShown ? -400.0 : -40.0)
                .offset(x: viewTranslation.width, y: viewTranslation.height)
                .offset(y: isBottomCardShown ? -180.0 : .zero)
                .scaleEffect(isBottomCardShown ? 1.0 : 0.9)
                .rotationEffect(.degrees(isShown ? .zero : 10.0))
                .rotationEffect(.degrees(isBottomCardShown ? -10.0 : .zero))
                .rotation3DEffect(.degrees(isBottomCardShown ? .zero : 10.0), axis: (x: 10.0, y: .zero, z: .zero))
                .animation(.easeInOut(duration: 0.5), value: isShown)
                .animation(.easeInOut(duration: 0.2), value: isBottomCardShown)
            BackCardView()
                .frame(width: isShown ? 375.0 : 340.0, height: 222.0)
                .background(Color.yellow)
                .cornerRadius(20.0)
                .shadow(radius: 20.0)
                .offset(x: .zero, y: isShown ? -200.0 : -20.0)
                .offset(x: viewTranslation.width, y: viewTranslation.height)
                .offset(y: isBottomCardShown ? -140.0 : .zero)
                .scaleEffect(isBottomCardShown ? 1.0 : 0.95)
                .rotationEffect(.degrees(isShown ? .zero : 5.0))
                .rotationEffect(.degrees(isBottomCardShown ? -5.0 : .zero))
                .rotation3DEffect(.degrees(isBottomCardShown ? .zero : 10.0), axis: (x: 5.0, y: .zero, z: .zero))
                .animation(.easeInOut(duration: 0.3), value: isShown)
                .animation(.easeInOut(duration: 0.1), value: isBottomCardShown)
            CardView()
                .frame(width: isShown ? 375.0 : 340.0, height: 222.0)
                .background(Color.indigo)
                .clipShape(RoundedRectangle(cornerRadius: isShown ? 30.0 : 20.0, style: .continuous))
                .shadow(radius: 20.0)
                .offset(x: viewTranslation.width, y: viewTranslation.height)
                .offset(y: isBottomCardShown ? -100.0 : .zero)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: .zero), value: viewTranslation)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: .zero), value: isBottomCardShown)
                .onTapGesture {
                    isBottomCardShown.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            viewTranslation = value.translation
                            isShown = true
                        }
                        .onEnded { value in
                            viewTranslation = .zero
                            isShown = false
                        }
                )
            BottomCardView()
                .offset(x: .zero, y: isBottomCardShown ? 400.0 : 1000.0)
                .offset(y: bottomCardTranslation.height)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1.0, duration: 0.8), value: isBottomCardShown)
                .animation(.default, value: bottomCardTranslation)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            bottomCardTranslation = value.translation
                            
                            if isBottomFullShown {
                                bottomCardTranslation.height += -300.0
                            }
                        }
                        .onEnded { value in
                            if bottomCardTranslation.height >= 50.0 {
                                isBottomCardShown = false
                            }
                            if bottomCardTranslation.height < -100.0 && !isBottomFullShown {
                                bottomCardTranslation.height = -300.0
                                isBottomFullShown = true
                            } else {
                                bottomCardTranslation = .zero
                                isBottomFullShown = false
                            }
                        }
                )
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Game Zone")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Text("Play with no limits")
                }
                Spacer()
                Image(uiImage: Resources.Images.controller)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44.0)
            }
            .padding(.horizontal, 20.0)
            Image(uiImage: Resources.Images.gameZone)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300.0, height: 110.0, alignment: .top)
        }
    }
}

struct BackCardView: View {
    
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.leading, 20.0)
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20.0) {
            Rectangle()
                .frame(width: 40.0, height: 5.0)
                .cornerRadius(3.0)
                .opacity(0.1)
            Text("Some text for now Some text for now Some text for now")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4.0)
            Spacer()
        }
        .padding(.top, 8.0)
        .padding(.horizontal, 20.0)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30.0)
        .shadow(radius: 20.0)
    }
}
