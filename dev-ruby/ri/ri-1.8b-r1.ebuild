# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ri/ri-1.8b-r1.ebuild,v 1.3 2004/11/04 16:14:39 usata Exp $

DESCRIPTION="Ruby Interactive reference"
HOMEPAGE="http://www.pragmaticprogrammer.com/ruby/downloads/ri.html"
SRC_URI="mirror://sourceforge/rdoc/${P}.tgz"

SLOT="0"
LICENSE="Ruby"
KEYWORDS="alpha ~hppa ~mips ~sparc x86 ppc ~amd64"

IUSE=""
DEPEND="=dev-lang/ruby-1.6*"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-config-0.3.1"

S=${WORKDIR}/${PN}

src_install () {
	DESTDIR=${D} ruby16 install.rb || die "install.rb failed"
	mv ${D}/usr/bin/ri{,16}	# let ruby-config make symlinks

	dodoc COPYING ChangeLog README
}

pkg_postinst() {
	${ROOT}usr/sbin/ruby-config $(readlink ${ROOT}usr/bin/ruby)
}
