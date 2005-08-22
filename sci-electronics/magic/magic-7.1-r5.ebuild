# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/magic/magic-7.1-r5.ebuild,v 1.1 2005/08/22 17:08:24 phosphan Exp $

inherit eutils flag-o-matic

DESCRIPTION="The VLSI design CAD tool"
HOMEPAGE="http://vlsi.cornell.edu/magic/"
SRC_URI="http://vlsi.cornell.edu/magic/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="sys-libs/ncurses
	sys-libs/readline"
DEPEND="${RDEPEND}
	sys-apps/findutils
	dev-lang/perl
	>=app-shells/tcsh-6.10-r3"


src_unpack() {
	unpack ${A}

	# Patch to use FHS paths
	epatch ${FILESDIR}/${P}-fhs.patch

	# Patch for GCC 3.2 compatibility
	epatch ${FILESDIR}/${P}-gcc3.2.patch

	# Add one more needed for GCC 3.4 (but earlier gcc won't mind)
	epatch ${FILESDIR}/${P}-remove-decl.patch

	# Fix endianness problem for ppc
	epatch ${FILESDIR}/${P}-ppc-endian.patch

	# some gcc 3.3 stuff, paths...
	cd ${S}
	# work around cvs problem
	sed -i 's/\$Header/\$NO_RCS_Header/' magic/proto.magic
	epatch ${FILESDIR}/${P}-misc.patch

	# Insert our idea of configuration file
	cp ${FILESDIR}/defs.mak-${PV}-r3 ${S}/defs.mak
	strip-flags
	sed -i  "/^CFLAGS/ s/=.*/= ${CFLAGS}/;" ${S}/defs.mak

	scripts/makedbh database/database.h.in database/database.h

	# Clean up all the pre-GCC-3.2 preprocessor directives
	einfo "Cleansing preprocessor directives"
	find ./ -name "*.[ch]" | xargs -n 1 perl -pi -e 's/^\#endif..*$/\#endif/'
	find ./ -name "*.[ch]" | xargs -n 1 perl -pi -e 's/^\#else..*$/\#else/'

	# Use ".magic-cad" rather than ".magic" as the config file to avoid
	# conflicts with "sys-apps/file" (see bug #74592).
	einfo 'Replacing occurences of ".magic" by ".magic-cad".'
	cd ${S}
	for i in extflat/*.c lisp/other/{*.c,Makefile.magic,:config} \
		macros/*.c magic/{Makefile,.\#Makefile.1.6,proto.magic} \
		magicusage/*.c main/*.c READ_ME scripts/config; do
		sed -e 's/ .magic/ .magic-cad/' \
			-e 's/".magic"/".magic-cad"/' \
			-e 's%/.magic%/.magic-cad%' \
			-i ${i} || die
	done
	rm -rf readline # we use the shared system library
	rm */Depend # contains links to magic's readline
}

src_compile() {
	# this program does not like optimizations or parallel builds
	make || die
	egrep -q "^make.*Error" make.log && die "Error while compiling - please add ${S}/make.log to your error report."
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /etc/env.d
	doins ${FILESDIR}/10magic
	keepdir /var/lock/magic
	chmod +t ${D}/var/lock/magic
	chmod ugo+rwx ${D}/var/lock/magic
	cd ${D}/usr/lib/magic
	mv * ${D}/usr/share/magic/
	cd ${D}/usr/lib
	mv *.h *.a magic/
	ln -s ../../share/magic/sys magic/sys
	ln -s ../../share/magic/scm magic/scm
	ln -s ../../share/magic/tutorial magic/tutorial

	# try to make man page names unique (many are so generic they collide)
	cd ${D}/usr/share/man
	find . -type f ! -name "*magic*" -exec \
		sh -c 'F=`echo {} | sed -e "s:\(man.\)/:\1/magic-:;"` ; mv "{}" "${F}" ' \;
	# Use ".magic" for the global config file.
	cd ${D}/usr/share/magic/sys
	mv .magic-cad .magic
	dodoc ${FILESDIR}/README.Gentoo
}

pkg_postinst() {
	ewarn 'On Gentoo systems, you should use "~/.magic-cad" as your personnal'
	ewarn 'Magic startup file rather than "~/.magic". For more details, see'
	ewarn '"README.Gentoo"'
}
