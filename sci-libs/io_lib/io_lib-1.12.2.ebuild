# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/io_lib/io_lib-1.12.2.ebuild,v 1.1 2010/05/28 22:50:17 jlec Exp $

EAPI="2"

DESCRIPTION="A general purpose trace and experiment file reading/writing interface"
HOMEPAGE="http://staden.sourceforge.net/"
SRC_URI="mirror://sourceforge/staden/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

# Prototype changes in io_lib-1.9.0 create incompatibilities with BioPerl. (Only
# versions 1.8.11 and 1.8.12 will work with the BioPerl Staden extensions.)
#DEPEND="!sci-biology/bioperl"
DEPEND="
	net-misc/curl
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_install() {
	einstall || die
	dodoc ChangeLog CHANGES README docs/{Hash_File_Format,ZTR_format} || die
}
