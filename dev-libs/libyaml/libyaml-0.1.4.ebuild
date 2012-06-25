# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libyaml/libyaml-0.1.4.ebuild,v 1.4 2012/06/25 07:38:04 jdhore Exp $

EAPI=4

inherit eutils

MY_P="${P/lib}"

DESCRIPTION="YAML 1.1 parser and emitter written in C"
HOMEPAGE="http://pyyaml.org/wiki/LibYAML"
SRC_URI="http://pyyaml.org/download/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="doc examples test static-libs"

S="${WORKDIR}/${MY_P}"

DOCS="README"

src_prepare() {
	# conditionally remove tests
	if use test; then
		sed -i -e 's: tests::g' Makefile*
	fi
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use doc && dohtml -r doc/html/.
	if use examples ; then
		docompress -x /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}/examples
		doins tests/example-*.c
	fi
}
