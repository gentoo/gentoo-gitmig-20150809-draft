# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

S=${WORKDIR}/${P}

DESCRIPTION="A small console program to send messages to spanish cellular phones"
SRC_URI="mirror://sourceforge/esms/${P}.tar.gz"
HOMEPAGE="http://esms.sourceforge.net"
KEYWORDS="x86"
LICENSE="GPL"
SLOT="0"

DEPEND=">=dev-perl/libwww-perl-5.64 \
	>=dev-perl/HTML-Parser-3.26 \
	>=dev-perl/HTML-Tree-3.11
	>=sys-devel/perl-5.6.1"

RDEPEND="${DEPEND}"

src_compile() {
	econf
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
}

