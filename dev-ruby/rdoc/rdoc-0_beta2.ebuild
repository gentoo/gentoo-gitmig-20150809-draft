# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-0_beta2.ebuild,v 1.6 2004/08/25 02:18:46 swegener Exp $

IUSE="X"

DESCRIPTION="RDoc produces documentation from Ruby source files"
HOMEPAGE="http://rdoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/rdoc/rdoc-beta-2.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/ruby-1.6.7
		X? ( >=media-gfx/graphviz-1.7.15-r2 )"

S=${WORKDIR}/"rdoc-beta-2"

src_compile() {
	use X && ruby rdoc.rb --diagram || ruby rdoc.rb
}

src_install () {
	export DESTDIR=${D}
	ruby install.rb || die

	dodoc ChangeLog EXAMPLE.rb NEW_FEATURES README ToDo
	cp -R contrib ${D}usr/share/doc/${PF}/${DOCDESTTREE}/
	cp -R etc ${D}usr/share/doc/${PF}/${DOCDESTTREE}/
	[ -d doc ] && dohtml -r doc/
}
