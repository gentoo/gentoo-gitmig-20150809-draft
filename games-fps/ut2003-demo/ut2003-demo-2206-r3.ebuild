# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2003-demo/ut2003-demo-2206-r3.ebuild,v 1.3 2004/04/02 03:54:20 wolf31o2 Exp $.

inherit games

DESCRIPTION="Unreal Tournament 2003 Demo"
HOMEPAGE="http://www.ut2003.com/"
SRC_URI="http://unreal.epicgames.com/linux/ut2003/ut2003demo-lnx-${PV}.sh.bin
	http://download.factoryunreal.com/mirror/UT2003CrashFix.zip"

LICENSE="ut2003-demo"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="nostrip"

DEPEND="virtual/opengl
	app-arch/unzip"
IUSE=""

S=${WORKDIR}

pkg_setup() {
	check_license
	games_pkg_setup
}

src_unpack() {
	unpack_makeself ${DISTDIR}/ut2003demo-lnx-${PV}.sh.bin \
		|| die "unpacking demo"
	unzip ${DISTDIR}/UT2003CrashFix.zip \
		|| die "unpacking crash-fix"
	tar -zxf setupstuff.tar.gz || die
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	tar -jxvf ut2003lnx_demo.tar.bz2 -C ${D}/${dir} || die
	tar -jxvf ${FILESDIR}/misc.tar.bz2 -C ${D}/${dir} || die

	# fix the benchmark configurations to use SDL rather than the Windows driver
	cd ${D}/${dir}/Benchmark/Stuff
	for f in MaxDetail.ini MinDetail.ini ; do
		dosed 's/RenderDevice=D3DDrv.D3DRenderDevice/\;RenderDevice=D3DDrv.D3DRenderDevice/' ${dir}/Benchmark/Stuff/${f}
		dosed 's/ViewportManager=WinDrv.WindowsClient/\;ViewportManager=WinDrv.WindowsClient/' ${dir}/Benchmark/Stuff/${f}
		dosed 's/\;RenderDevice=OpenGLDrv.OpenGLRenderDevice/RenderDevice=OpenGLDrv.OpenGLRenderDevice/' ${dir}/Benchmark/Stuff/${f}
		dosed 's/\;ViewportManager=SDLDrv.SDLClient/ViewportManager=SDLDrv.SDLClient/' ${dir}/Benchmark/Stuff/${f}
	done

	# have the benchmarks run the nifty wrapper script rather than ../System/ut2003-bin directly
	cd ${D}/opt/ut2003-demo/Benchmark
	for f in ${D}/${dir}/Benchmark/*-*.sh ; do
		dosed 's:\.\./System/ut2003-bin:../ut2003_demo:' ${f}
	done

	# Wrapper and benchmark-scripts
	insinto ${GAMES_BINDIR}
	dogamesbin ${FILESDIR}/ut2003-demo
	exeinto ${dir}/Benchmark
	doexe ${FILESDIR}/{benchmark,results.sh}

	# Here we apply DrSiN's crash patch
	cp ${S}/CrashFix/System/crashfix.u ${Ddir}/System

ed ${Ddir}/System/Default.ini >/dev/null 2>&1 <<EOT
$
?Engine.GameInfo?
a
AccessControlClass=crashfix.iaccesscontrolini
.
w
q
EOT

	# create menu entry (closes bug #27594)
	insinto /usr/share/applications
	newins ${S}/opt/ut2003-demo/Unreal.xpm UT2003-demo.xpm
	make_desktop_entry ut2003-demo "Unreal Tournament 2003 (Demo)" UT2003-demo.xpm

	prepgamesdirs
}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " ut2003"
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
