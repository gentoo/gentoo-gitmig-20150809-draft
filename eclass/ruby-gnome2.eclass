# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby-gnome2.eclass,v 1.1 2003/08/06 13:31:54 agriffis Exp $
#
# This eclass simplifies installation of the various pieces of
# ruby-gnome2 since they share a very common installation procedure.
# It's possible that this could provide a foundation for a generalized
# ruby-module.eclass, but at the moment it contains some things
# specific to ruby-gnome2

ECLASS=ruby-gnome2
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS src_compile src_install

IUSE=""

subbinding=${PN#ruby-} ; subbinding=${subbinding%2}
S=${WORKDIR}/ruby-gnome2-${PV}/${subbinding}
SRC_URI="mirror://sourceforge/ruby-gnome2/ruby-gnome2-${PV}.tar.gz"
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/"
LICENSE="Ruby"
SLOT="0"

DEPEND="${DEPEND} >=dev-lang/ruby-1.6"
RDEPEND="${RDEPEND} >=dev-lang/ruby-1.6"

ruby-gnome2_src_compile() {
	ruby extconf.rb || die "extconf.rb failed"
	emake || die "emake failed"
}

ruby-gnome2_src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ../AUTHORS ../NEWS ChangeLog README
	if [[ -d sample ]]; then
		dodir /usr/share/doc/${PF}
		cp -a sample ${D}/usr/share/doc/${PF} || die "cp failed"
	fi
}
