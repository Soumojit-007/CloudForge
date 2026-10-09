import { useEffect , useState } from "react";
import {
  Activity,
  Cloud,
  Container,
  GitBranch,
  RefreshCw,
  Server,
  ShieldCheck,
  Zap,
} from "lucide-react";

const API_URL = import.meta.env.VITE_API_URL || "";

type Health = {
  status : string,
  service: string,
  version: string,
  environment:string
}

function App(){
  const [health , setHealth] = useState<Health |null>(null)
  const [loading , setLoading] = useState(false)

  const [error , setError] = useState("")

  async function fetchHealth() {
    setLoading(true)
    setError("")

    try {
      const response = await fetch(`${API_URL}/api/health`)
      if(!response.ok) throw new Error("Backend health check failed~!!!")
        setHealth(await response.json())
    } catch (error) {
      console.log("The actual error is here, ", error);
      
      setError("Backend is unreachable. Check the API and Kubernetes service")
      setHealth(null)
    }
    finally{
      setLoading(false)
    }
  }

  useEffect(() =>{
    void fetchHealth();
    const interval = setInterval(() => void fetchHealth() , 30000)
    return () => clearInterval(interval);
  }, [])

   const cards = [
    {
      title: "API Health",
      value: loading ? "Checking..." : health?.status ?? "Unavailable",
      detail: "Flask backend",
      icon: Activity,
      color: "text-emerald-400",
    },
    {
      title: "Cloud Platform",
      value: "Microsoft Azure",
      detail: "Cloud infrastructure",
      icon: Cloud,
      color: "text-sky-400",
    },
    {
      title: "Containers",
      value: "Docker + ACR",
      detail: "Build and image registry",
      icon: Container,
      color: "text-violet-400",
    },
    {
      title: "Orchestration",
      value: "Azure AKS",
      detail: "Kubernetes workloads",
      icon: Server,
      color: "text-amber-400",
    },
  ];

   return (
    <div className="min-h-screen bg-slate-950 text-slate-100">
      <header className="border-b border-slate-800 bg-slate-900/80">
        <div className="mx-auto flex max-w-7xl items-center justify-between px-6 py-5">
          <div className="flex items-center gap-3">
            <div className="rounded-xl bg-blue-500/15 p-3 text-blue-400">
              <Cloud size={26} />
            </div>
            <div>
              <h1 className="text-xl font-bold tracking-tight">CloudForge</h1>
              <p className="text-xs text-slate-400">
                Infrastructure Control Center
              </p>
            </div>
          </div>

          <button
            onClick={() => void fetchHealth()}
            disabled={loading}
            className="flex items-center gap-2 rounded-lg border border-slate-700 px-4 py-2 text-sm transition hover:bg-slate-800 disabled:opacity-50"
          >
            <RefreshCw size={15} className={loading ? "animate-spin" : ""} />
            Refresh
          </button>
        </div>
      </header>

      <main className="mx-auto max-w-7xl space-y-8 px-6 py-10">
        <section>
          <p className="mb-2 text-sm font-medium text-blue-400">
            DEVOPS OVERVIEW
          </p>
          <h2 className="text-3xl font-bold sm:text-4xl">
            Infrastructure Dashboard
          </h2>
          <p className="mt-3 max-w-2xl text-slate-400">
            Monitor your application health and explore the technologies
            powering your CloudForge deployment.
          </p>
        </section>

        {error && (
          <div
            role="alert"
            className="rounded-xl border border-red-500/30 bg-red-500/10 p-4 text-sm text-red-300"
          >
            {error}
          </div>
        )}

        <section className="grid gap-5 sm:grid-cols-2 xl:grid-cols-4">
          {cards.map((card) => {
            const Icon = card.icon;
            return (
              <article
                key={card.title}
                className="rounded-2xl border border-slate-800 bg-slate-900 p-6 transition hover:border-slate-700"
              >
                <div className="mb-5 flex items-center justify-between">
                  <span className="text-sm text-slate-400">{card.title}</span>
                  <Icon className={card.color} size={22} />
                </div>
                <p className="break-words text-xl font-semibold">
                  {card.value}
                </p>
                <p className="mt-2 text-sm text-slate-500">{card.detail}</p>
              </article>
            );
          })}
        </section>

        <section className="grid gap-6 lg:grid-cols-3">
          <article className="rounded-2xl border border-slate-800 bg-slate-900 p-6 lg:col-span-2">
            <div className="mb-6 flex items-center gap-3">
              <GitBranch className="text-blue-400" size={22} />
              <h3 className="text-lg font-semibold">Delivery Pipeline</h3>
            </div>

            <div className="grid gap-3 sm:grid-cols-4">
              {["GitHub", "Azure DevOps", "Docker + ACR", "AKS"].map(
                (step, index) => (
                  <div
                    key={step}
                    className="rounded-xl border border-slate-800 bg-slate-950 p-4"
                  >
                    <p className="mb-2 text-xs text-slate-500">
                      STEP 0{index + 1}
                    </p>
                    <p className="text-sm font-medium">{step}</p>
                  </div>
                ),
              )}
            </div>

            <p className="mt-4 text-sm text-slate-500">
              Your goal: automate the journey from a Git commit to a running
              application in Kubernetes.
            </p>
          </article>

          <article className="rounded-2xl border border-slate-800 bg-slate-900 p-6">
            <div className="mb-5 flex items-center gap-3">
              <ShieldCheck className="text-emerald-400" size={22} />
              <h3 className="text-lg font-semibold">Runtime Details</h3>
            </div>

            <div className="space-y-4 text-sm">
              <div className="flex justify-between gap-3">
                <span className="text-slate-400">Service</span>
                <span>{health?.service ?? "CloudForge API"}</span>
              </div>
              <div className="flex justify-between gap-3">
                <span className="text-slate-400">Version</span>
                <span>{health?.version ?? "—"}</span>
              </div>
              <div className="flex justify-between gap-3">
                <span className="text-slate-400">Environment</span>
                <span>{health?.environment ?? "—"}</span>
              </div>
              <div className="flex items-center gap-2 border-t border-slate-800 pt-4 text-slate-400">
                <Zap size={16} className="text-amber-400" />
                Refreshes every 30 seconds
              </div>
            </div>
          </article>
        </section>

        <footer className="border-t border-slate-800 pt-6 text-center text-xs text-slate-500">
          CloudForge · Built with React, Flask, Docker, Terraform and Azure
        </footer>
      </main>
    </div>
  );
}


export default App;