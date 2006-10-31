# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15daemon/g15daemon-1.2.3.ebuild,v 1.1 2006/10/31 22:29:10 jokey Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit eutils linux-info perl-module python autotools

DESCRIPTION="G15daemon takes control of the G15 keyboard, through the linux kernel uinput device driver"
HOMEPAGE="http://g15daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/g15daemon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="perl python"

DEPEND="dev-libs/libusb
	dev-libs/libdaemon
	dev-libs/libg15
	perl? ( >=dev-perl/Inline-0.4 )
	python? ( dev-lang/python )"

RDEPEND="${DEPEND}
	perl? ( dev-perl/GDGraph )"

uinput_check() {
	ebegin "Checking for uinput support"
	linux_chkconfig_present INPUT_UINPUT
	eend $?

	if [[ $? -ne 0 ]] ; then
		eerror "To use g15daemon, you need to compile your kernel with uinput support."
		eerror "Please enable uinput support in your kernel config, found at:"
		eerror
		eerror "Device Drivers -> Input Device ... -> Miscellaneous devices -> User level driver support."
		eerror
		eerror "Once enabled, you should have the /dev/input/uinput device."
		eerror "g15daemon will not work without the uinput device."
		die "INPUT_UINPUT support not detected!"
	fi
}

pkg_setup() {
	linux-info_pkg_setup
	uinput_check
}

src_unpack() {
	unpack ${A}
	if use perl; then
		unpack "./${P}/lang-bindings/perl-G15Daemon-0.2.tar.gz"
	fi
	if use python; then
		unpack "./${P}/lang-bindings/pyg15daemon-0.0.tar.bz2"
	fi
	cd "${S}"

	# needed because the shipped ltmain is old and
	# to avoid regeneration of configure by the program itself
	eautoreconf
}

src_compile() {
	econf || die "configure failed"

	emake || die "make failed"

	if use perl; then
		cd "${WORKDIR}/G15Daemon-0.2"
		perl-module_src_compile
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS NEWS README TODO ChangeLog

	insinto /usr/share/g15daemon/contrib
	doins contrib/xmodmaprc
	doins contrib/xmodmap.sh
	if use perl; then
		doins contrib/testbindings.pl
	fi

	newinitd "${FILESDIR}/g15daemon-${PV}.initd" g15daemon

	if use perl; then
		einfo "Installing Perl Bindings (G15Daemon.pm)"
		cd "${WORKDIR}/G15Daemon-0.2"
		perl-module_src_install
	fi

	if use python; then
		einfo "Installing Python Bindings (g15daemon.py)"
		cd "${WORKDIR}/pyg15daemon"
		python_version

		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/g15daemon
		doins g15daemon.py
		newdoc AUTHORS pyg15daemon_AUTHORS
	fi
}

pkg_postinst() {
	if use python; then
		python_mod_optimize "${ROOT}/usr/lib/python*/site-packages/g15daemon"
		einfo ""
	fi

	einfo "To use g15daemon, you need to add g15daemon to the default runlevel."
	einfo "This can be done with:"
	einfo "# /sbin/rc-update add g15daemon default"
	einfo ""
	einfo "To have all new keys working in X11,"
	einfo "you'll need create a specific xmodmap in your home directory"
	einfo "or edit the existant one."
	einfo ""
	einfo "create the xmodmap:"
	einfo "cp /usr/share/g15daemon/contrib/xmodmaprc ~/.Xmodmap"
	einfo ""
	einfo "adding keycodes to an existing xmodmap:"
	einfo "cat /usr/share/g15daemon/contrib/xmodmaprc >> ~/.Xmodmap"
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup "${ROOT}/usr/lib/python*/site-packages/g15daemon"
	fi
}