# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/php-docs/php-docs-20050822.ebuild,v 1.11 2006/04/22 22:41:20 flameeyes Exp $

DESCRIPTION="HTML documentation for PHP"
HOMEPAGE="http://www.php.net/download-docs.php"
SRC_URI="http://dev.gentoo.org/~stuart/php/${PN}-${PVR}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/html

src_install() {
	# the whole structure is too much to do with a simple dohtml *

	for x in a b c d e f g h i j k l m n o p q r s t u v w x y z ; do
		dohtml function.$x*
		rm function.$x*
	done

	# what's left will fit into a single dohtml *
	dohtml *
}

pkg_postinst() {
	einfo "Creating symlink to PHP manual at /usr/share/php-docs"
	[[ -e /usr/share/php-docs ]] && rm -f /usr/share/php-docs
	ln -s /usr/share/doc/php-docs-${PVR}/html /usr/share/php-docs
}
