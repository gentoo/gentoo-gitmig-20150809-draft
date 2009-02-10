# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/oprofile/oprofile-0.9.4.ebuild,v 1.6 2009/02/10 00:19:25 spock Exp $

EAPI=1

inherit eutils qt3 linux-info

DESCRIPTION="A transparent low-overhead system-wide profiler"
HOMEPAGE="http://oprofile.sourceforge.net"
SRC_URI="mirror://sourceforge/oprofile/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="qt3"
DEPEND=">=dev-libs/popt-1.7-r1
	>=sys-devel/binutils-2.14.90.0.6-r3
	>=sys-libs/glibc-2.3.2-r1
	qt3? ( x11-libs/qt:3 )"

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_chkconfig_present OPROFILE; then
		elog "In order for oprofile to work, you need to configure your kernel"
		elog "with CONFIG_OPROFILE set to 'm' or 'y'."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
	epatch "${FILESDIR}/${P}-open.patch"
}

src_compile() {
	local myconf=""

	if use qt3
	then
		REALHOME="$HOME"
		mkdir -p "$T"/fakehome/.kde
		mkdir -p "$T"/fakehome/.qt
		export HOME="$T/fakehome"
		addwrite "${QTDIR}/etc/settings"

		# things that should access the real homedir
		[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"
	else
		myconf="${myconf} --with-qt-dir=/void"
	fi

	myconf="${myconf} --with-x"

	case ${KV_FULL} in
	2.2.*|2.4.*) myconf="${myconf} --with-linux=${KV_DIR}";;
	2.5.*|2.6.*) myconf="${myconf} --with-kernel-support";;
	*) die "Kernel version '${KV_FULL}' not supported";;
	esac
	econf ${myconf} || die "econf failed"

	local mymake=""

	sed -i -e "s,depmod -a,:,g" Makefile
	emake ${mymake} || die "emake failed"
}

src_install() {
	local myinst=""

	myinst="${myinst} MODINSTALLDIR=${D}/lib/modules/${KV_FULL}"
	make DESTDIR="${D}" ${myinst} htmldir="/usr/share/doc/${PF}" install || die "make install failed"

	dodoc ChangeLog* README TODO
}

pkg_postinst() {
	if [[ ${ROOT} == / ]] ; then
		[[ -x /sbin/update-modules ]] && /sbin/update-modules || /sbin/modules-update
	fi

	echo
	elog "Now load the oprofile module by running:"
	elog "  # opcontrol --init"
	elog "Then read manpages and this html doc:"
	elog "  /usr/share/doc/oprofile/oprofile.html"
	echo
}
