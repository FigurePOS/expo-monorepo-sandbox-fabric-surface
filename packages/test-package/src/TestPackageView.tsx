import { requireNativeView } from 'expo';
import * as React from 'react';

import { TestPackageViewProps } from './TestPackage.types';

const NativeView: React.ComponentType<TestPackageViewProps> =
  requireNativeView('TestPackage');

export default function TestPackageView(props: TestPackageViewProps) {
  return <NativeView {...props} />;
}
