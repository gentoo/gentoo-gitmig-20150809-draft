# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby-cvs/ruby-cvs-1.8.0.ebuild,v 1.1 2003/04/15 09:40:19 twp Exp $

DESCRIPTION="An object-oriented scripting language"
SRC_URI=""
HOMEPAGE="http://www.ruby-lang.org/"
LICENSE="Ruby"
KEYWORDS="~alpha ~arm ~hppa ~mips ~ppc ~sparc ~x86"
SLOT="0"
PROVIDE="dev-lang/ruby-${PV}"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2"

ECVS_SERVER="cvs.ruby-lang.org:/src"
ECVS_MODULE="ruby"
ECVS_AUTH="pserver"
ECVS_PASS="anonymous"
inherit cvs

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {

	local ruby_version=`gawk '$2=="RUBY_VERSION" {print $3}' version.h | tr -d \"`
	if [ "${PV}" != "${ruby_version}" ]; then
		die "version mismatch"
	fi

	autoconf || die
	CFLAGS=${CFLAGS/-fomit-frame-pointer/} econf
	emake

}

src_install () {
	einstall
	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}
