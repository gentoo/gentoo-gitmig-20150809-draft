# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-9.0.0.ebuild,v 1.1 2009/11/30 01:35:11 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
MY_PACKAGE="Words"

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1)*
	=dev-python/twisted-web-$(get_version_component_range 1)*"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="twisted/plugins twisted/words"

src_install() {
	twisted_src_install

	# Remove the "im" script, because we do not depend on the required pygtk.
	rm -fr "${D}"usr/{bin,share/man}
}
