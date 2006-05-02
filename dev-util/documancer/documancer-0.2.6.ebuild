# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/documancer/documancer-0.2.6.ebuild,v 1.3 2006/05/02 00:22:52 halcy0n Exp $

inherit eutils

DESCRIPTION="Programmer's documentation reader with very fast fulltext searching"
HOMEPAGE="http://documancer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# If pylucene makes it into the tree, we can add it as a dep
# || ( dev-python/pylucene virtual/jre )

RDEPEND=">=x11-libs/wxmozilla-0.5.6
	>=virtual/python-2.3
	>=dev-python/wxpython-2.6.3
	virtual/jre
	dev-lang/perl"

pkg_setup () {
	# Note: can't use "python_mod_exists wxPython.mozilla" here because
	#       it doesn't work (some strange import stuff in wxPython)
	if ! built_with_use wxmozilla python; then
		eerror "you need wxmozilla compiled with Python module:"
		eerror "echo \"x11-libs/wxmozilla python\" >> /etc/portage/package.use"
		eerror "and then emerge wxmozilla"
		die "Need wxMozilla compiled with Python module!"
	fi
}

src_install () {
	make install DESTDIR=${D} || die

	dodoc AUTHORS FAQ NEWS README TODO
}
