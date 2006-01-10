# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2003-demo/ut2003-demo-2206-r3.ebuild,v 1.14 2006/01/10 16:00:46 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Unreal Tournament 2003 Demo"
HOMEPAGE="http://www.ut2003.com/"
SRC_URI="http://unreal.epicgames.com/linux/ut2003/ut2003demo-lnx-${PV}.sh.bin
	http://download.factoryunreal.com/mirror/UT2003CrashFix.zip
	http://dev.gentoo.org/~wolf31o2/sources/${PN}/${PN}-misc.tar.bz2"

LICENSE="ut2003-demo"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="nostrip"

DEPEND="app-arch/unzip"
RDEPEND="virtual/opengl
	=virtual/libstdc++-3.3
	x86? (
		|| (
			(
				x11-libs/libX11
				x11-libs/libXext )
			virtual/x11 ) )
	amd64? (
		app-emulation/emul-linux-x86-xlibs )"

S="${WORKDIR}"
dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

pkg_setup() {
	check_license ut2003-demo
	games_pkg_setup
}

src_unpack() {
	unpack_makeself ${DISTDIR}/ut2003demo-lnx-${PV}.sh.bin \
		|| die "unpacking demo"
	unzip "${DISTDIR}/UT2003CrashFix.zip" \
		|| die "unpacking crash-fix"
	tar -zxf setupstuff.tar.gz || die
}

src_install() {
	local f

	einfo "This will take a while ... go get a pizza or something"

	dodir "${dir}"

	tar -jxvf ut2003lnx_demo.tar.bz2 -C "${Ddir}" || die
	tar -jxvf "${DISTDIR}/${PN}-misc.tar.bz2" -C "${Ddir}" || die

	# fix the benchmark configurations to use SDL rather than the Windows driver
	for f in MaxDetail.ini MinDetail.ini ; do
		sed -i \
			-e 's/RenderDevice=D3DDrv.D3DRenderDevice/\;RenderDevice=D3DDrv.D3DRenderDevice/' \
			-e 's/ViewportManager=WinDrv.WindowsClient/\;ViewportManager=WinDrv.WindowsClient/' \
			-e 's/\;RenderDevice=OpenGLDrv.OpenGLRenderDevice/RenderDevice=OpenGLDrv.OpenGLRenderDevice/' \
			-e 's/\;ViewportManager=SDLDrv.SDLClient/ViewportManager=SDLDrv.SDLClient/' \
			"${Ddir}/Benchmark/Stuff/${f}" \
			|| die "sed ${dir}/Benchmark/Stuff/${f} failed"
	done

	# have the benchmarks run the nifty wrapper script rather than ../System/ut2003-bin directly
	for f in "${Ddir}/Benchmark/"*-*.sh ; do
		sed -i \
			-e 's:\.\./System/ut2003-bin:../ut2003_demo:' "${f}" \
			|| die "sed ${f} failed"
	done

	# Wrapper and benchmark-scripts
	dogamesbin "${FILESDIR}/ut2003-demo" || die "dogamesbin failed"
	exeinto "${dir}/Benchmark"
	doexe "${FILESDIR}/"{benchmark,results.sh} || die "doexe failed"

	# Here we apply DrSiN's crash patch
	cp "${S}/CrashFix/System/crashfix.u" "${Ddir}/System" \
		|| die "CrashFix failed"

ed "${Ddir}/System/Default.ini" >/dev/null 2>&1 <<EOT
$
?Engine.GameInfo?
a
AccessControlClass=crashfix.iaccesscontrolini
.
w
q
EOT

	newicon Unreal.xpm ut2003-demo.xpm
	make_desktop_entry ut2003-demo "Unreal Tournament 2003 (Demo)" ${PN}.xpm

	prepgamesdirs
}

pkg_postinst() {
	einfo "To play the demo run:"
	einfo " ut2003-demo"
	echo
	einfo "You can run benchmarks by typing 'ut2003-demo --bench' (MinDetail seems"
	einfo "to not be working for some unknown reason :/)"
	echo
	einfo "Read ${dir}/README.linux for instructions on how to run a"
	einfo "dedicated server."
	echo
	ewarn "If you are not installing for the first time and you plan on running"
	ewarn "a server, you will probably need to edit your"
	ewarn "~/.ut2003demo/System/UT2003.ini file and add a line that says"
	ewarn "AccessControlClass=crashfix.iaccesscontrolini to your"
	ewarn "[Engine.GameInfo] section to close a security issue."

	games_pkg_postinst
}
