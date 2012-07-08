# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.25.1_p20120708.ebuild,v 1.1 2012/07/08 23:26:02 cardoe Exp $

EAPI=4

PYTHON_DEPEND="python? 2"
BACKPORTS="61e7a0e946"
MY_P=${P%_p*}

inherit flag-o-matic multilib eutils python user

#MYTHTV_VERSION="v${PV}-15-g${MYTHTV_SREV}"
#MYTHTV_BRANCH="fixes/0.25"
#MYTHTV_REV="c29d36f1634cd837276b4fd8cfea5d5d75304da8"
#MYTHTV_SREV="c29d36f"

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="http://www.mythtv.org"
SRC_URI="ftp://ftp.osuosl.org/pub/mythtv/mythtv-0.25.1.tar.bz2
	${BACKPORTS:+http://dev.gentoo.org/~cardoe/distfiles/${MY_P}-${BACKPORTS}.tar.xz}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

IUSE_INPUT_DEVICES="input_devices_joystick"
IUSE="alsa altivec libass autostart bluray cec crystalhd debug dvb dvd \
ieee1394 jack lcd lirc perl pulseaudio python xvmc vaapi vdpau \
${IUSE_INPUT_DEVICES}"

SDEPEND="
	>=media-sound/lame-3.93.1
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXv
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	x11-libs/qt-core:4
	x11-libs/qt-dbus
	x11-libs/qt-gui:4
	x11-libs/qt-sql:4[mysql]
	x11-libs/qt-opengl:4
	x11-libs/qt-webkit:4
	virtual/mysql
	virtual/opengl
	virtual/glu
	alsa? ( >=media-libs/alsa-lib-1.0.24 )
	cec? ( dev-libs/libcec )
	dvb? ( media-libs/libdvb virtual/linuxtv-dvb-headers )
	ieee1394? (	>=sys-libs/libraw1394-1.2.0
			>=sys-libs/libavc1394-0.5.3
			>=media-libs/libiec61883-1.0.0 )
	jack? ( media-sound/jack-audio-connection-kit )
	lcd? ( app-misc/lcdproc )
	libass? ( >=media-libs/libass-0.9.11 )
	lirc? ( app-misc/lirc )
	perl? (	dev-perl/DBD-mysql
		dev-perl/Net-UPnP
		dev-perl/LWP-Protocol-https
		dev-perl/HTTP-Message
		dev-perl/IO-Socket-INET6
		>=dev-perl/libwww-perl-5 )
	pulseaudio? ( media-sound/pulseaudio )
	python? (	dev-python/mysql-python
			dev-python/lxml
			dev-python/urlgrabber )
	vaapi? ( x11-libs/libva )
	vdpau? ( x11-libs/libvdpau )
	xvmc? ( x11-libs/libXvMC )
	!media-tv/mythtv-bindings
	!x11-themes/mythtv-themes
	"

RDEPEND="${SDEPEND}
	media-fonts/corefonts
	media-fonts/dejavu
	>=media-libs/freetype-2.0
	x11-apps/xinit
	|| ( >=net-misc/wget-1.12-r3 >=media-tv/xmltv-0.5.43 )
	autostart? (	net-dialup/mingetty
			x11-wm/evilwm
			x11-apps/xset )
	bluray? ( media-libs/libbluray )
	dvd? ( media-libs/libdvdcss )
	"

DEPEND="${SDEPEND}
	dev-lang/yasm
	x11-proto/xineramaproto
	x11-proto/xf86vidmodeproto
	"

MYTHTV_GROUPS="video,audio,tty,uucp"

pkg_setup() {
	einfo "This ebuild now uses a heavily stripped down version of your CFLAGS"

	use python && python_set_active_version 2
	python_pkg_setup

	enewuser mythtv -1 /bin/bash /home/mythtv ${MYTHTV_GROUPS}
	usermod -a -G ${MYTHTV_GROUPS} mythtv
}

src_prepare() {
# upstream wants the revision number in their version.cpp
# since the subversion.eclass strips out the .svn directory
# svnversion in MythTV's build doesn't work
#	sed -e "s#\${SOURCE_VERSION}#${MYTHTV_VERSION}#g" \
#		-e "s#\${BRANCH}#${MYTHTV_BRANCH}#g" \
#		-i "${S}"/version.sh

	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	# Perl bits need to go into vender_perl and not site_perl
	sed -e "s:pure_install:pure_install INSTALLDIRS=vendor:" \
		-i "${S}"/bindings/perl/Makefile

	epatch_user
}

src_configure() {
	local myconf="--prefix=/usr"
	myconf="${myconf} --mandir=/usr/share/man"
	myconf="${myconf} --libdir-name=$(get_libdir)"

	myconf="${myconf} --enable-pic"
	myconf="${myconf} --enable-symbol-visibility"

	use alsa       || myconf="${myconf} --disable-audio-alsa"
	use altivec    || myconf="${myconf} --disable-altivec"
	use jack       || myconf="${myconf} --disable-audio-jack"
	use pulseaudio || myconf="${myconf} --disable-audio-pulseoutput"

	myconf="${myconf} $(use_enable dvb)"
	myconf="${myconf} $(use_enable ieee1394 firewire)"
	myconf="${myconf} $(use_enable lirc)"
	myconf="${myconf} --dvb-path=/usr/include"
	myconf="${myconf} --enable-xrandr"
	myconf="${myconf} --enable-xv"
	myconf="${myconf} --enable-x11"

	if use perl && use python; then
		myconf="${myconf} --with-bindings=perl,python"
	elif use perl; then
		myconf="${myconf} --without-bindings=python"
		myconf="${myconf} --with-bindings=perl"
	elif use python; then
		myconf="${myconf} --without-bindings=perl"
		myconf="${myconf} --with-bindings=python"
	else
		myconf="${myconf} --without-bindings=perl,python"
	fi

	use python && myconf="${myconf} --python=$(PYTHON)"

	if use debug; then
		myconf="${myconf} --compile-type=debug"
	else
		myconf="${myconf} --compile-type=profile"
		myconf="${myconf} --enable-proc-opt"
	fi

	use vdpau && myconf="${myconf} --enable-vdpau"
	use vaapi && myconf="${myconf} --enable-vaapi"
	use crystalhd && myconf="${myconf} --enable-crystalhd"

	use input_devices_joystick || myconf="${myconf} --disable-joystick-menu"

	# Clean up DSO load times
	myconf="${myconf} --enable-symbol-visibility"

## CFLAG cleaning so it compiles
	strip-flags

	has distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
	has ccache ${FEATURES} || myconf="${myconf} --disable-ccache"

# let MythTV come up with our CFLAGS. Upstream will support this
	CFLAGS=""
	CXXFLAGS=""

	chmod +x ./external/FFmpeg/version.sh

	einfo "Running ./configure ${myconf}"
	./configure ${myconf} || die "configure died"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	dodoc AUTHORS UPGRADING README

	insinto /usr/share/mythtv/database
	doins database/*

	newinitd "${FILESDIR}"/mythbackend.init mythbackend
	newconfd "${FILESDIR}"/mythbackend.conf mythbackend

	dodoc keys.txt

	keepdir /etc/mythtv
	chown -R mythtv "${ED}"/etc/mythtv
	keepdir /var/log/mythtv
	chown -R mythtv "${ED}"/var/log/mythtv

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/mythtv.logrotate.d-r1 mythtv

	insinto /usr/share/mythtv/contrib
	doins -r contrib/*

	newbin "${FILESDIR}"/runmythfe-r1 runmythfe

	if use autostart; then
		dodir /etc/env.d/
		echo 'CONFIG_PROTECT="/home/mythtv/"' > "${ED}"/etc/env.d/95mythtv

		insinto /home/mythtv
		newins "${FILESDIR}"/bash_profile .bash_profile
		newins "${FILESDIR}"/xinitrc .xinitrc
	fi

	for file in `find "${ED}" -type f -name \*.py`; do chmod a+x "${file}"; done
	for file in `find "${ED}" -type f -name \*.sh`; do chmod a+x "${file}"; done
	for file in `find "${ED}" -type f -name \*.pl`; do chmod a+x "${file}"; done
}

pkg_preinst() {
	export CONFIG_PROTECT="${CONFIG_PROTECT} ${EROOT}/home/mythtv/"
}

pkg_postinst() {
	use python && python_mod_optimize MythTV

	elog "To have this machine operate as recording host for MythTV, "
	elog "mythbackend must be running. Run the following:"
	elog "rc-update add mythbackend default"
	elog
	elog "Your recordings folder must be owned 'mythtv'. e.g."
	elog "chown -R mythtv /var/lib/mythtv"

	elog "Want mythfrontend to start automatically?"
	elog "Set USE=autostart. Details can be found at:"
	elog "http://dev.gentoo.org/~cardoe/mythtv/autostart.html"
}

pkg_postrm() {
	use python && python_mod_cleanup MythTV
}

pkg_info() {
	if [[ -f "${EROOT}"/usr/bin/mythfrontend ]]; then
		"${EROOT}"/usr/bin/mythfrontend --version
	fi
}

pkg_config() {
	echo "Creating mythtv MySQL user and mythconverg database if it does not"
	echo "already exist. You will be prompted for your MySQL root password."
	"${EROOT}"/usr/bin/mysql -u root -p < "${EROOT}"/usr/share/mythtv/database/mc.sql
}
