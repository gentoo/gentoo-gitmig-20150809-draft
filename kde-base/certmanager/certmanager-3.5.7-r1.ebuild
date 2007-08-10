# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/certmanager/certmanager-3.5.7-r1.ebuild,v 1.6 2007/08/10 14:21:59 angelos Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdepim-3.5-patchset-04.tar.bz2"

DESCRIPTION="KDE certificate manager gui."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdenetwork)
	>=app-crypt/gpgme-1.1.2-r1
	|| ( >=app-crypt/gnupg-2.0.1-r1 <app-crypt/gnupg-1.9 )"
	# We use GnuPG 1.4.x for OpenPGP and 1.9 (via gpgme) for s/mime as upstream advises.

KMCOPYLIB="libqgpgme libkdenetwork/qgpgme/"
KMEXTRACTONLY="libkdenetwork/
	libkpgp/
	libkdepim/"

KMEXTRA="doc/kleopatra
	doc/kwatchgnupg"

src_compile() {
	myconf="--with-gpg=/usr/bin/gpg"
	kde_src_compile
}

pkg_postinst() {
	kde_pkg_postinst
	elog "For X.509 CRL and OCSP support, install app-crypt/dirmngr, please."
}
