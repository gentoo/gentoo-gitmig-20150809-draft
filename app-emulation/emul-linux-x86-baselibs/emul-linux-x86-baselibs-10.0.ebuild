# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-baselibs/emul-linux-x86-baselibs-10.0.ebuild,v 1.4 2007/02/13 14:04:01 blubb Exp $

DESCRIPTION="Provides precompiled 32bit libraries"
HOMEPAGE="http://amd64.gentoo.org/emul/content.xml"
SRC_URI="mirror://gentoo/binutils-2.16.1-r3.tbz2
		mirror://gentoo/bzip2-1.0.3-r6.tbz2
		mirror://gentoo/com_err-1.39.tbz2
		mirror://gentoo/cracklib-2.8.9-r1.tbz2
		mirror://gentoo/cups-1.2.6.tbz2
		mirror://gentoo/db-4.0.14-r3.tbz2
		mirror://gentoo/db-4.2.52_p4-r2.tbz2
		mirror://gentoo/dbus-1.0.2.tbz2
		mirror://gentoo/dbus-glib-0.72.tbz2
		mirror://gentoo/dbus-qt3-old-0.70.tbz2
		mirror://gentoo/e2fsprogs-1.39.tbz2
		mirror://gentoo/expat-1.95.8.tbz2
		mirror://gentoo/file-4.18.tbz2
		mirror://gentoo/gamin-0.1.8.tbz2
		mirror://gentoo/gdbm-1.8.3-r3.tbz2
		mirror://gentoo/glib-1.2.10-r5.tbz2
		mirror://gentoo/glib-2.12.7.tbz2
		mirror://gentoo/gpm-1.20.1-r5.tbz2
		mirror://gentoo/jpeg-6b-r7.tbz2
		mirror://gentoo/lcms-1.14-r1.tbz2
		mirror://gentoo/libart_lgpl-2.3.17.tbz2
		mirror://gentoo/libidn-0.5.15.tbz2
		mirror://gentoo/libmng-1.0.9-r1.tbz2
		mirror://gentoo/libperl-5.8.8-r1.tbz2
		mirror://gentoo/libpng-1.2.15.tbz2
		mirror://gentoo/libtool-1.5.22.tbz2
		mirror://gentoo/libxml2-2.6.27.tbz2
		mirror://gentoo/ncurses-5.5-r3.tbz2
		mirror://gentoo/nss_ldap-253.tbz2
		mirror://gentoo/openldap-2.3.30-r2.tbz2
		mirror://gentoo/openssl-0.9.8d.tbz2
		mirror://gentoo/pam-0.78-r5.tbz2
		mirror://gentoo/pwdb-0.62.tbz2
		mirror://gentoo/readline-5.1_p4.tbz2
		mirror://gentoo/slang-1.4.9-r2.tbz2
		mirror://gentoo/ss-1.39.tbz2
		mirror://gentoo/tiff-3.8.2-r2.tbz2
		mirror://gentoo/zlib-1.2.3-r1.tbz2"

LICENSE="|| ( Artistic GPL-2 ) || ( BSD GPL-2 ) BZIP2 CRACKLIB DB
		GPL-2 || ( GPL-2 AFL-2.1 ) LGPL-2 LGPL-2.1 MIT OPENLDAP openssl
		PAM ZLIB as-is"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RESTRICT="nostrip"
S=${WORKDIR}

DEPEND=""
RDEPEND=""

pkg_setup() {
	einfo
	elog "This package contains prebuilt versions of the following packages:"
	for a in ${A} ; do
		elog "	${a//.tbz2}"
	done
	einfo
	echo
	einfo "Note: You can safely ignore the 'trailing garbage after EOF'"
	einfo "      warnings below"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	rm -rf {usr/,}{s,}bin/
	rm -rf var/
	rm -rf etc/env.d/binutils/

	local dir=${S}/etc
	find ${dir} -depth | egrep -v "(^${dir}/env.d|^${dir}$)" | xargs rm -rf

	rm -rf usr/i686-pc-linux-gnu
	rm -rf usr/include
	[[ -d usr/lib ]] && rm -rf usr/lib/
	rm -rf usr/libexec
	rm -rf usr/share
}

src_install() {
	# nobody needs *.la, *.h *.a
	find ${S} -type f -name '*.a' -or -name '*.la' -or -name '*.h' \
		| xargs rm -f

	
	for dir in etc/env.d etc/revdep-rebuild ; do
		if [[ -d ${S}/${dir} ]] ; then
			for f in ${S}/${dir}/* ; do
				mv -f $f{,-emul}
			done
		fi
	done

	cp -a "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
}
