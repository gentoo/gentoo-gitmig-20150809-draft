# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby-gnome2.eclass,v 1.5 2003/12/29 16:21:49 usata Exp $
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
if [[ ${PV} == 0.5.0 ]]; then
	S=${WORKDIR}/ruby-gnome2-${PV}/${subbinding}
	SRC_URI="mirror://sourceforge/ruby-gnome2/ruby-gnome2-${PV}.tar.gz"
else
	S=${WORKDIR}/ruby-gnome2-all-${PV}/${subbinding}
	SRC_URI="mirror://sourceforge/ruby-gnome2/ruby-gnome2-all-${PV}.tar.gz"
fi
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/"
LICENSE="Ruby"
SLOT="0"

if [[ ${PV} == 0.5.0 ]]; then
	newdepend ">=dev-lang/ruby-1.6"
	newrdepend ">=dev-lang/ruby-1.6"
else
	# Not necessarily true, but nobody's testing the newer ruby-gnome2
	# with the older ruby...
	newdepend ">=dev-lang/ruby-1.8"
	newrdepend ">=dev-lang/ruby-1.8"
fi

ruby-gnome2_src_compile() {
	ruby extconf.rb || die "extconf.rb failed"
	emake || die "emake failed"
}

ruby-gnome2_src_install() {
	dodir $(ruby -r rbconfig -e 'print Config::CONFIG["sitearchdir"]')
	make DESTDIR=${D} install || die "make install failed"
	for doc in ../AUTHORS ../NEWS ChangeLog README; do
		[ -s "$doc" ] && dodoc $doc
	done
	if [[ -d sample ]]; then
		dodir /usr/share/doc/${PF}
		cp -a sample ${D}/usr/share/doc/${PF} || die "cp failed"
	fi
}
