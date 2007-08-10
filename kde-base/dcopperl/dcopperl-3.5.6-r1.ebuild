# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcopperl/dcopperl-3.5.6-r1.ebuild,v 1.4 2007/08/10 14:05:30 angelos Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"

inherit kde-meta perl-app

DESCRIPTION="Perl bindings for DCOP"
KEYWORDS="amd64 ~ppc ppc64 sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

PATCHES="$FILESDIR/no-gtk-glib-check.diff
	$FILESDIR/installdirs-vendor.diff" # install into vendor_perl, not into site_perl - bug 42819

# Because this installs into /usr/lib/perl5/..., it doesn't have SLOT=X.Y like the rest of KDE,
# and it installs into /usr entirely
SLOT="0"

pm_echovar=" "

# Ugly, but necessary.
KDEDIRS="/usr/kde/3.5"

S="${WORKDIR}/${P}/dcopperl"

src_unpack(){
	kde-meta_src_unpack
}

src_compile() {
	perl-module_src_prep
	sed -i -e "s:DESTDIR = :DESTDIR = ${D}:" Makefile
	perl-module_src_compile
	fixlocalpod
}

# note uses perl-module_pkg_postinst for more local.pod magic, was bug 83520
