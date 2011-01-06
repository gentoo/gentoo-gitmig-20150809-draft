# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-10.2.0.ebuild,v 1.4 2011/01/06 21:36:24 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
MY_PACKAGE="Words"

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ppc ppc64 s390 sh sparc ~x86"
IUSE=""

DEPEND="=dev-python/twisted-$(get_version_component_range 1)*
	=dev-python/twisted-web-$(get_version_component_range 1)*"
RDEPEND="${DEPEND}"

PYTHON_MODNAME="twisted/plugins twisted/words"

src_install() {
	twisted_src_install

	# Remove the "im" script, because we do not depend on the required pygtk.
	rm -fr "${ED}"usr/{bin,share/man}
}
