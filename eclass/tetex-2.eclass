# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/tetex-2.eclass,v 1.1 2005/04/05 17:07:45 usata Exp $
#
# Author: Jaromir Malenko <malenko@email.cz>
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# A generic eclass to install tetex 2.0.x distributions.

inherit tetex

ECLASS=tetex-2
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS src_unpack src_install

tetex-2_src_unpack() {

	tetex_src_unpack

	cd ${S}/texmf

	unpack ${TETEX_TEXMF_SRC}
	sed -i -e "s/-sys//g" ${T}/texmf-update || die

	# fix up misplaced listings.sty in the 2.0.2 archive. 
	# this should be fixed in the next release <obz@gentoo.org>
	mv source/latex/listings/listings.sty tex/latex/listings/ || die

	# need to fix up the hyperref driver, see bug #31967
	sed -i -e "/providecommand/s/hdvips/hypertex/" \
		${S}/texmf/tex/latex/config/hyperref.cfg || die
}

tetex-2_src_install() {

	tetex_src_install

	# bug #47004
	insinto /usr/share/texmf/tex/latex/a0poster
	doins ${S}/texmf/source/latex/a0poster/a0poster.cls || die
	doins ${S}/texmf/source/latex/a0poster/a0size.sty || die

	rm -f ${D}/usr/bin/texi2html
	rm -f ${D}/usr/share/man/man1/texi2html.1

	dodir /etc/env.d/
	echo 'CONFIG_PROTECT="/usr/share/texmf/tex/generic/config/ /usr/share/texmf/tex/platex/config/ /usr/share/texmf/dvips/config/ /usr/share/texmf/dvipdfm/config/ /usr/share/texmf/xdvi/"' > ${D}/etc/env.d/98tetex

	#fix for texlinks
	local src dst
	sed -e '/^#/d' -e '/^$/d' -e 's/^ *//' \
		${D}/usr/share/texmf/web2c/fmtutil.cnf > ${T}/fmtutil.cnf || die
	while read l; do
		dst=/usr/bin/`echo $l | awk '{ print $1 }'`
		src=/usr/bin/`echo $l | awk '{ print $2 }'`
		if [ ! -f ${D}$dst -a "$dst" != "$src" ] ; then
			einfo "Making symlinks from $src to $dst"
			dosym $src $dst
		fi
	done < ${T}/fmtutil.cnf
}
