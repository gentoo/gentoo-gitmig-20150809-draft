# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/micq/micq-0.4.10.2.ebuild,v 1.1 2003/03/31 02:28:30 kutsuya Exp $
 
SRC_URI="ftp://www.micq.org/pub/micq/source/${P}.tgz
	http://www.micq.org/source/${P}.tgz"
DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.micq.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"
       
src_install() {
    make DESTDIR=${D} install || die
}
