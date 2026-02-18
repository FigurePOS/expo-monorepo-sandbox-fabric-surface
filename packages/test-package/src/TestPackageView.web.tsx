import * as React from "react";

import { TestPackageViewProps } from "./TestPackage.types";

export default function TestPackageView(props: TestPackageViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
