# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-8.2.0.ebuild,v 1.1 2009/01/24 16:50:16 patrick Exp $

MY_PACKAGE=Words

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1)*
	=dev-python/twisted-web-$(get_version_component_range 1)*"

src_install() {
	twisted_src_install

	# Remove the "im" script we do not depend on the required pygtk.
	rm -rf "${D}"/usr/{bin,share/man}
}
