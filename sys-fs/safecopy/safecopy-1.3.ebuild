# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/safecopy/safecopy-1.3.ebuild,v 1.1 2009/05/27 12:04:01 scarabeus Exp $

EAPI="2"
inherit base eutils

DESCRIPTION="Data recovery tool to fault-tolerantly extract data from damaged (io-errors) devices or files."
HOMEPAGE="http://safecopy.sourceforge.net"
SRC_URI="mirror://sourceforge/safecopy/${P}.tar.gz -> ${P}.tar.gz
http://sourceforge.net/tracker/download.php?group_id=141056&atid=748330&file_id=328461&aid=2796779 -> ${P}-amd64.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=(
	"${FILESDIR}/${P}-sandbox.patch"
	"${WORKDIR}/${P}-amd64.patch"
)

src_install() {
	base_src_install
	dodoc README || die "copying documentation failed"
}

src_test() {
	einfo "Starting test phase:"
	cd "${S}"/test/libsafecopydebug
	einfo "Compiling safecopy test suite..."
	econf
	emake || die "Compilation of safecopy test failed ?!"

	cd "${S}"/test/
	ebegin "Running safecopy self test..."
	./test.sh
	eend $? || die "Test run failed"
}
