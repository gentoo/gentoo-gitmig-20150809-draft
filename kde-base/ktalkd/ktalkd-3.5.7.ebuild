# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktalkd/ktalkd-3.5.7.ebuild,v 1.8 2007/08/10 14:39:33 angelos Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE talk daemon"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
KMEXTRA="doc/kcontrol/kcmktalkd"

RDEPEND="|| ( net-misc/netkit-talk net-misc/ytalk sys-freebsd/freebsd-ubin )"

pkg_postinst() {
	kde_pkg_postinst

	if has_version net-misc/ytalk ; then
		elog "To use net-misc/ytalk as your local network chat program, please"
		elog "configure your system accordingly, either via the KDE control center"
		elog "or by calling \"kcmshell kcmktalkd\" on the command line."
	fi
}
