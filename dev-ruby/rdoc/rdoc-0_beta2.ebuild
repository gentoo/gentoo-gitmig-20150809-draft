# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdoc/rdoc-0_beta2.ebuild,v 1.1 2002/08/20 04:30:10 george Exp $

DESCRIPTION="RDoc produces documentation from Ruby source files"
HOMEPAGE="http://rdoc.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/rdoc/rdoc-beta-2.tgz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/ruby-1.6.7
		X? ( >=media-gfx/graphviz-1.7.15-r2 )"
RDEPEND="${DEPEND}"

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
