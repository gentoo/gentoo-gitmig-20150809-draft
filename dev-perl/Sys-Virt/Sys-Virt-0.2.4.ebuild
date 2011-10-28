# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Virt/Sys-Virt-0.2.4.ebuild,v 1.1 2011/10/28 17:38:57 maksbotan Exp $

EAPI=3

MODULE_AUTHOR="DANBERR"
inherit perl-module

DESCRIPTION="Sys::Virt provides an API for using the libvirt library from Perl"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

ALL_DEPEND=">=app-emulation/libvirt-0.8.1"
DEPEND="${ALL_DEPEND}
	virtual/perl-Time-HiRes
	dev-util/pkgconfig"
RDEPEND="${ALL_DEPEND}"
SRC_TEST="do"

src_compile() {
	perl_set_version

	make -j1 OTHERLDFLAGS="${LDFLAGS}" ${mymake} || die "compilation failed"
}
