import { useBottomTabBarHeight } from '@react-navigation/bottom-tabs';
import { BlurView } from 'expo-blur';
import { StyleSheet } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';

export default function BlurTabBarBackground() {
  return (
    <BlurView
      // System chrome material automatically adapts to the system's theme
      // and matches the native tab bar appearance on iOS.
      tint="systemChromeMaterial"
      intensity={100}
      style={StyleSheet.absoluteFill}
    />
  );
}

export function useBottomTabOverflow() {
  const { bottom } = useSafeAreaInsets();
  let tabHeight = bottom;

  // `useBottomTabBarHeight` throws if this screen isn't inside a Bottom Tab
  // Navigator. That can happen in some Expo Router dev flows or when this
  // component is reused elsewhere, so fall back gracefully.
  try {
    tabHeight = useBottomTabBarHeight();
  } catch {
    tabHeight = bottom;
  }

  return Math.max(tabHeight - bottom, 0);
}
