# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/stgit/stgit-0.14.3.ebuild,v 1.3 2009/05/09 22:11:50 robbat2 Exp $

inherit distutils bash-completion

DESCRIPTION="Manage a stack of patches using GIT as a backend"
HOMEPAGE="http://www.procode.org/stgit/"
SRC_URI="http://homepage.ntlworld.com/cmarinas/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-util/git-1.5"
DEPEND="$RDEPEND"

src_install() {
	sed -i -e 's-\(prefix:\) ~-\1 /usr-' setup.cfg
	distutils_src_install
	dodir /usr/share/doc/${PF}
	mv "${D}/usr/share/${PN}/examples" "${D}/usr/share/doc/${PF}"
	rmdir "${D}/usr/share/doc/${PN}"
	dobashcompletion contrib/stgit-completion.bash ${PN}
}

src_test() {
	export PATH=/usr/libexec/git-core/:$PATH 
	emake -j1 test
}
