import React from "react";
import Link from "@docusaurus/Link";
import useDocusaurusContext from "@docusaurus/useDocusaurusContext";
import Layout from "@theme/Layout";
import useBaseUrl from "@docusaurus/useBaseUrl";
import { Redirect } from "@docusaurus/router";

// function HomepageHeader() {
//   const { siteConfig } = useDocusaurusContext();
//   return (
//     <header className="block h-[85vh] bg-[#30a091] p-8">
//       <div className="mx-auto mt-40 block text-center">
//         <h1 className="text-6xl font-semibold text-zinc-200">
//           {siteConfig.title}
//         </h1>
//         <p className="mt-4 text-base text-zinc-200">{siteConfig.tagline}</p>
//         <div className="mt-8">
//           <Link
//             className="rounded-lg bg-white px-4 py-2 text-zinc-800 shadow"
//             to="/docs/intro"
//           >
//             1分ではじめる！ ⏱️
//           </Link>
//         </div>
//       </div>
//     </header>
//   );
// }

// export default function Home(): JSX.Element {
//   const { siteConfig } = useDocusaurusContext();
//   return (
//     <Layout
//       title={`Hello from ${siteConfig.title}`}
//       description="Description will go into a meta tag in <head />"
//     >
//       <HomepageHeader />
//       {/* <main><HomepageFeatures /></main> */}
//     </Layout>
//   );
// }

function Home() {
  return <Redirect to={useBaseUrl("docs/intro")} />;
}

export default Home;
