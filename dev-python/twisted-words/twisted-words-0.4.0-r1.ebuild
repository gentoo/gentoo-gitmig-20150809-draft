# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-0.4.0-r1.ebuild,v 1.5 2006/10/20 20:39:42 kloeri Exp $

MY_PACKAGE=Words

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="alpha amd64 ia64 ~ppc ~sparc ~x86"

DEPEND=">=dev-python/twisted-2.4
	dev-python/twisted-web
	gtk? ( <dev-python/pygtk-2 )"

IUSE="gtk"


src_install() {
	twisted_src_install

	if ! use gtk; then
		# Remove the "im" script if we do not depend on the required pygtk.
		rm -rf "${D}"/usr/{bin,share/man}
	fi
}
