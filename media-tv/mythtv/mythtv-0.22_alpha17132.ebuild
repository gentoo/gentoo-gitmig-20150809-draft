# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.22_alpha17132.ebuild,v 1.1 2008/04/23 16:42:45 cardoe Exp $

EAPI=1
inherit flag-o-matic multilib eutils qt4 mythtv toolchain-funcs python

DESCRIPTION="Homebrew PVR project"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE_VIDEO_CARDS="video_cards_nvidia video_cards_via"
IUSE="alsa altivec autostart debug directv dvb dvd \
ieee1394 jack lcd lirc mmx opengl opengl-video \
opengl-xvmc perl python xvmc ${IUSE_VIDEO_CARDS}"

RDEPEND=">=media-libs/freetype-2.0
	>=media-sound/lame-3.93.1
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXv
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	>=x11-libs/qt-4.3:4
	virtual/mysql
	virtual/opengl
	virtual/glu
	|| ( >=net-misc/wget-1.9.1 >=media-tv/xmltv-0.5.43 )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	autostart? ( net-dialup/mingetty
				x11-wm/evilwm
				x11-apps/xset )
	directv? ( virtual/perl-Time-HiRes )
	dvb? ( media-libs/libdvb media-tv/linuxtv-dvb-headers )
	dvd? ( 	media-libs/libdvdnav )
	ieee1394? (	>=sys-libs/libraw1394-1.2.0
			>=sys-libs/libavc1394-0.5.3
			>=media-libs/libiec61883-1.0.0 )
	jack? ( media-sound/jack-audio-connection-kit )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	perl? ( dev-perl/DBD-mysql )
	python? ( dev-python/mysql-python )
	opengl-xvmc? ( >=x11-drivers/nvidia-drivers-100 )
	xvmc? ( x11-libs/libXvMC
		app-admin/eselect-xvmc )"

DEPEND="${RDEPEND}
	x11-proto/xineramaproto
	x11-proto/xf86vidmodeproto
	x11-apps/xinit"

PDEPEND="=x11-themes/mythtv-themes-${MY_PV}*"

S="${WORKDIR}/${PN}-${MY_PV}"

MYTHTV_GROUPS="video,audio,tty,uucp"

pkg_setup() {

	if ! built_with_use -a =x11-libs/qt-4* gif jpeg mysql opengl png tiff; then
		echo
		eerror "MythTV requires Qt to be built with gif, jpeg, mysql, opengl,"
		eerror "png, and tiff use flags enabled."
		eerror "Please re-emerge =x11-libs/qt-4*, after having the use flags set."
		echo
		die "Please fix the above issues, before continuing."
	fi

	echo
	einfo "This ebuild now uses a heavily stripped down version of your CFLAGS"
	einfo "Don't complain because your -momfg-fast-speed CFLAG is being stripped"
	einfo "Only additional CFLAG issues that will be addressed are for binary"
	einfo "package building."
	echo

	if use xvmc && use opengl-xvmc ; then
		einfo "Enabling USE=opengl-xvmc results in an experimental OpenGL"
		einfo "& XvMC renderer that only works on NVIDIA GeForce 4,5,6, & 7"
		einfo "series of cards. It is typically slower then stock XVideo"
		einfo "support that is the default in MythTV."
		echo
	fi

	if use opengl-video ; then
		einfo "Enabling USE=opengl-video results in an experimental OpenGL"
		einfo "renderer that is typically slower then the default XVideo"
		einfo "renderer. Enable at your own risk."
		echo
	fi

	enewuser mythtv -1 /bin/bash /home/mythtv ${MYTHTV_GROUPS} || die "Problem adding mythtv user"
	usermod -a -G ${MYTHTV_GROUPS} mythtv
}

src_unpack() {
	subversion_src_unpack

	# upstream wants the revision number in their version.cpp
	# since the subversion.eclass strips out the .svn directory
	# svnversion in MythTV's build doesn't work
	sed -e "s:\`(svnversion \$\${SVNTREEDIR} 2>\/dev\/null) || echo Unknown\`:${MYTHTV_REV}:" \
		-i "${S}"/version.pro || die "svnversion sed failed"

	# Perl bits need to go into vender_perl and not site_perl
	sed -e "s:pure_install:pure_install INSTALLDIRS=vendor:" \
		-i "${S}"/bindings/perl/perl.pro
}

src_compile() {
	local myconf="--prefix=/usr
		--mandir=/usr/share/man
		--libdir-name=$(get_libdir)"
	use alsa || myconf="${myconf} --disable-audio-alsa"
	use altivec || myconf="${myconf} --disable-altivec"
	use jack || myconf="${myconf} --disable-audio-jack"
	use opengl-video && myconf="${myconf} --enable-opengl-video"
	use xvmc && ! use video_cards_via  ! use opengl-xvmc && myconf="${myconf} --enable-xvmc --xvmc-lib=XvMCW"
	use xvmc && use video_cards_via && myconf="${myconf} --enable-xvmc --enable-xvmc-pro"
	use xvmc && use video_cards_nvidia && use opengl-xvmc && myconf="${myconf} --enable-xvmc --enable-xvmc-opengl"
	# nvidia-drivers-71 don't support GLX 1.4
	use video_cards_nvidia && has_version =x11-drivers/nvidia-drivers-71* \
		&& myconf="${myconf} --enable-glx-procaddrarb"

	myconf="${myconf}
		$(use_enable dvb)
		$(use_enable ieee1394 firewire)
		$(use_enable lirc)
		--disable-audio-arts
		--disable-directfb
		--dvb-path=/usr/include
		--enable-opengl-vsync
		--enable-xrandr
		--enable-xv
		--enable-x11
		--enable-gpl"

	if use mmx || use amd64; then
		myconf="${myconf} --enable-mmx"
	else
		myconf="${myconf} --disable-mmx"
	fi

	if use perl && use python; then
		myconf="${myconf} --with-bindings=perl,python"
	elif use perl; then
		myconf="${myconf} --with-bindings=perl"
	elif use python; then
		myconf="${myconf} --with-bindings=python"
	else
		myconf="${myconf} --without-bindings=perl,python"
	fi

	if use debug; then
		myconf="${myconf} --compile-type=debug"
	else
		myconf="${myconf} --compile-type=profile"
	fi

	## CFLAG cleaning so it compiles
	MARCH=$(get-flag "march")
	MTUNE=$(get-flag "mtune")
	strip-flags
	filter-flags "-march=*" "-mtune=*" "-mcpu=*"
	filter-flags "-O" "-O?"

	if [[ -n "${MARCH}" ]]; then
		myconf="${myconf} --cpu=${MARCH}"
	fi
	if [[ -n "${MTUNE}" ]]; then
		myconf="${myconf} --tune=${MTUNE}"
	fi

#	myconf="${myconf} --extra-cxxflags=\"${CXXFLAGS}\" --extra-cflags=\"${CFLAGS}\""
	hasq distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
	hasq ccache ${FEATURES} || myconf="${myconf} --disable-ccache"

	# let MythTV come up with our CFLAGS. Upstream will support this
	CFLAGS=""
	CXXFLAGS=""
	einfo "Running ./configure ${myconf}"
	./configure ${myconf} || die "configure died"

	eqmake4 mythtv.pro -o "Makefile" || die "eqmake4 failed"
	emake || die "emake failed"

	# firewire support should build the tester
	if use ieee1394; then
		cd contrib
		$(tc-getCC) ${CFLAGS} ${CPPFLAGS} -o ../firewire_tester \
			development/firewire_tester/firewire_tester.c \
			${LDFLAGS} -liec61883 -lraw1394 || \
			die "failed to compile firewire_tester"

		cd channel_changers
		$(tc-getCC) ${CFLAGS} ${CPPFLAGS} -std=gnu99 -o ../../6200ch \
			6200ch/6200ch.c \
			${LDFLAGS} -lrom1394 -lavc1394 -lraw1394 || \
			die "failed to compile 6200ch"
		$(tc-getCC) ${CFLAGS} ${CPPFLAGS} -o ../../sa3250ch \
			sa3250ch/sa3250ch.c \
			${LDFLAGS} -lrom1394 -lavc1394 -lraw1394 || \
			die "failed to compile sa3250ch"
	fi

	cd "${S}"/contrib/channel_changers
	$(tc-getCC) ${CFLAGS} ${CPPFLAGS} -o ../../red_eye red_eye/red_eye.c \
		${LDFLAGS} || die "failed to compile red_eye"
}

src_install() {

	einstall INSTALL_ROOT="${D}" || die "install failed"
	dodoc AUTHORS FAQ UPGRADING  README

	insinto /usr/share/mythtv/database
	doins database/*

	exeinto /usr/share/mythtv
	doexe "${FILESDIR}/mythfilldatabase.cron"

	newinitd "${FILESDIR}"/mythbackend-0.18.2.rc mythbackend
	newconfd "${FILESDIR}"/mythbackend-0.18.2.conf mythbackend

	dodoc keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html

	keepdir /etc/mythtv
	chown -R mythtv "${D}"/etc/mythtv
	keepdir /var/log/mythtv
	chown -R mythtv "${D}"/var/log/mythtv

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/mythtv.logrotate.d mythtv

	insinto /usr/share/mythtv/contrib
	doins -r contrib/*

	dobin "${FILESDIR}"/runmythfe

	if use autostart; then
		dodir /etc/env.d/
		echo 'CONFIG_PROTECT="/home/mythtv/"' > "${D}"/etc/env.d/95mythtv

		insinto /home/mythtv
		newins "${FILESDIR}"/bash_profile .bash_profile
		newins "${FILESDIR}"/xinitrc .xinitrc
	fi

	if use ieee1394; then
		dobin firewire_tester || die "failed to install firewire_tester"
		newdoc contrib/development/firewire_tester/README README.firewire_tester

		dobin 6200ch || die "failed to install 6200ch"
		newdoc contrib/channel_changers/6200ch/README README.6200ch

		dobin sa3250ch || die "failed to install sa3250ch"
		newdoc contrib/channel_changers/sa3250ch/README README.sa3250ch
	fi

	dobin red_eye || die "failed to install red_eye"
	newdoc contrib/channel_changers/red_eye/README README.red_eye

	if use directv; then
		dobin contrib/channel_changers/d10control.pl || die "failed to install d10control"
		newdoc contrib/channel_changers/d10control/README README.d10control
	fi
}

pkg_preinst() {
	export CONFIG_PROTECT="${CONFIG_PROTECT} ${ROOT}/home/mythtv/"
}

pkg_postinst() {
	python_version
	python_mod_optimize "${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages/MythTV"

	echo
	elog "Want mythfrontend to start automatically?"
	elog "Set USE=autostart. Details can be found at:"
	elog "http://dev.gentoo.org/~cardoe/mythtv/autostart.html"

	echo
	elog "To always have MythBackend running and available run the following:"
	elog "rc-update add mythbackend default"
	echo
	ewarn "Your recordings folder must be owned by the user 'mythtv' now"
	ewarn "chown -R mythtv /path/to/store"

	if use xvmc; then
		echo
		elog "Please set the proper XvMC provider with eselect xvmc"
	fi

	if use autostart; then
		echo
		elog "Please add the following to your /etc/inittab file at the end of"
		elog "the TERMINALS section"
		elog "c8:2345:respawn:/sbin/mingetty --autologin mythtv tty8"
	fi

}

pkg_postrm()
{
	python_version
	python_mod_cleanup "/usr/$(get_libdir)/python${PYVER}/site-packages/MythTV"
}

pkg_info() {
	"${ROOT}"/usr/bin/mythfrontend --version
}

pkg_config() {
	echo "Creating mythtv MySQL user and mythconverg database if it does not"
	echo "already exist. You will be prompted for your MySQL root password."
	"${ROOT}"/usr/bin/mysql -u root -p < "${ROOT}"/usr/share/mythtv/database/mc.sql
}
