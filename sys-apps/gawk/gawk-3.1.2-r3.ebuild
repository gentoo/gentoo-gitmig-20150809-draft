# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gawk/gawk-3.1.2-r3.ebuild,v 1.4 2003/05/20 19:52:11 azarah Exp $

IUSE="nls build"

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="GNU awk pattern-matching language"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gawk/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gawk/gawk.html"

KEYWORDS="x86 ppc sparc alpha mips hppa arm"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	# Copy filefuncs module's source over ...
	cp -a ${FILESDIR}/filefuncs ${WORKDIR}/ || die

	cd ${S}
	# Special files like those in /proc, report themselves as regular files
	# of length 0, when in fact they have data in them if you try to read them.
	# The new record-reading code wasn't quite smart enough to deal with such
	# a bizarre case.  The following patch fixes the problem, thanks to 
	# Arnold D. Robbins (Maintainer of gawk).
	epatch ${FILESDIR}/${P}-input-filesize.patch
}

src_compile() {
	local myconf=""
	use nls || myconf="${myconf} --disable-nls"

	einfo "Building gawk ..."
	./configure --prefix=/usr \
		--libexecdir=/usr/lib/awk \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--host=${CHOST} \
		${myconf} || die

	emake || die

	einfo "Building filefuncs module ..."
	cd ${WORKDIR}/filefuncs
	make AWKINCDIR=${S} || die
}

src_install() {
	einfo "Installing gawk ..."
	make prefix=${D}/usr \
		bindir=${D}/bin \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		libexecdir=${D}/usr/lib/awk \
		install || die

	einfo "Installing filefuncs module ..."
	cd ${WORKDIR}/filefuncs
	make DESTDIR=${D} \
		AWKINCDIR=${S} \
		install || die

	# In some rare cases, gawk gets installed as gawk- and not gawk-${PV} ..
	if [ -f ${D}/bin/gawk -a ! -f ${D}/bin/gawk-${PV} ]
	then
		mv -f ${D}/bin/gawk ${D}/bin/gawk-${PV}
	elif [ -f ${D}/bin/gawk- -a ! -f ${D}/bin/gawk-${PV} ]
	then
		mv -f ${D}/bin/gawk ${D}/bin/gawk-${PV}
	fi
	
	rm -f ${D}/bin/{awk,gawk}
	dosym gawk-${PV} /bin/awk
	dosym gawk-${PV} /bin/gawk
	#compat symlink
	dodir /usr/bin
	dosym ../../bin/gawk-${PV} /usr/bin/awk
	dosym ../../bin/gawk-${PV} /usr/bin/gawk

	# Install headers
	insinto /usr/include/awk
	for x in ${S}/*.h
	do
		# We do not want 'acconfig.h' in there ...
		if [ -f "${x}" -a "${x/acconfig\.h/}" = "${x}" ]
		then
			doins ${x}
		fi
	done
	
	if [ -z "`use build`" ] 
	then
		cd ${S}
		dosym gawk.1.gz /usr/share/man/man1/awk.1.gz
		dodoc AUTHORS ChangeLog COPYING FUTURES
		dodoc LIMITATIONS NEWS PROBLEMS POSIX.STD README
		docinto README_d
		dodoc README_d/*
		docinto awklib
		dodoc awklib/ChangeLog
		docinto pc
		dodoc pc/ChangeLog
		docinto posix
		dodoc posix/ChangeLog
	else
		rm -rf ${D}/usr/share
	fi
}

