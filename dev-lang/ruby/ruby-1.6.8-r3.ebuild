# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.6.8-r3.ebuild,v 1.4 2004/03/25 08:35:01 kumba Exp $

IUSE="ruby16"

inherit flag-o-matic alternatives eutils
filter-flags -fomit-frame-pointer

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="mirror://ruby/${PV%.*}/${P/_pre/-preview}.tar.gz"

LICENSE="Ruby"
SLOT="1.6"
KEYWORDS="x86 alpha ppc sparc hppa amd64 -ia64"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gdbm-1.8.0
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2"

pkg_setup() {

	einfo
	einfo "If you want to use ruby-1.6 by default you need to set"
	einfo "\tUSE=\"ruby16\""
	einfo "otherwise ruby-1.8 will be used."
	einfo
}

src_unpack() {
	unpack ${A}
	cd ${S}
	use amd64 && epatch ${FILESDIR}/${P}-fix-x86_64.patch
}

src_compile() {
	econf --program-suffix=16 --enable-shared || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dosym /usr/lib/libruby16.so.${PV} /usr/lib/libruby.so.${PV%.*}
	dosym /usr/lib/libruby16.so.${PV} /usr/lib/libruby.so.${PV}

	if has_version '>=dev-lang/ruby-1.8.0-r1'; then
		dobin ${FILESDIR}/ruby-config
	fi

	dodoc COPYING* ChangeLog MANIFEST README* ToDo
}

ruby_alternatives() {
	if [ -n "`use ruby16`" ] ; then
		alternatives_makesym /usr/bin/ruby /usr/bin/ruby{16,18}
		alternatives_makesym /usr/bin/irb /usr/bin/irb{16,18}
		alternatives_makesym /usr/lib/libruby.so \
			/usr/lib/libruby{16,18}.so
		alternatives_makesym /usr/share/man/man1/ruby.1.gz \
			/usr/share/man/man1/ruby{16,18}.1.gz
	else
		alternatives_makesym /usr/bin/ruby /usr/bin/ruby{18,16}
		alternatives_makesym /usr/bin/irb /usr/bin/irb{18,16}
		alternatives_makesym /usr/lib/libruby.so \
			/usr/lib/libruby{18,16}.so
		alternatives_makesym /usr/share/man/man1/ruby.1.gz \
			/usr/share/man/man1/ruby{18,16}.1.gz
	fi
}

pkg_postinst() {
	ruby_alternatives

	if [ -x "/usr/bin/ruby-config" ] ; then
	einfo
	einfo "You can switch default ruby by /usr/bin/ruby-config."
	einfo
	fi
}

pkg_postrm() {
	ruby_alternatives
}
