# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/xephem/xephem-3.7.1.ebuild,v 1.1 2006/07/28 14:56:59 phosphan Exp $

DESCRIPTION="XEphem is the X Windows Ephemeris, and provides a scientific-grade solar system model, star charts, sky views, plus a whole lot more."
SRC_URI="http://www.clearskyinstitute.com/xephem/${P}.tar.gz"
HOMEPAGE="http://www.clearskyinstitute.com/xephem"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
SLOT="0"
LICENSE="as-is"
DEPEND="virtual/motif"


src_unpack() {
	unpack ${A}
	cd ${S}
	for i in libastro/Makefile libip/Makefile libjpegd/Makefile \
		liblilxml/Makefile GUI/xephem/Makefile GUI/xephem/tools/*/Makefile ; do
		einfo "Fixing CFLAGS in ${i}"
		sed -e "s~^CFLAGS[ ]*=\(.*\)-O2\(.*\)~CFLAGS= \1 \2 ${CFLAGS}~" -i ${i} \
			|| die "sed failed"
	done
	sed -e 's~^CFLAGS[ ]*=\(.*\)$(CLDFLAGS)\(.*\)~CFLAGS=\1 \2~' \
		-i GUI/xephem/Makefile
}

src_compile() {

	cd libastro
	emake || die
	local myldflags
	cd ${S}
	for dir in libip liblilxml libjpegd GUI/xephem/tools/* GUI/xephem; do
		echo "going into ${dir}"
		cd ${S}/${dir}
		if [ ${dir:0:3} = "lib" ]; then
			myldflags=""
		else
			myldflags="${CLDFLAGS}"
		fi
		emake CLDFLAGS="${myldflags}" || die
	done
}

src_install() {

	into /usr
	cd ${S}/GUI/xephem
	dobin xephem
	for file in tools/indi/{evalINDI,getINDI,setINDI,tmount,ota,wx,cam,security,indiserver} \
		tools/{lx200xed/lx200xed,xedb/xedb,xephemdbd/xephemdbd}; do
		dobin ${file}
	done
	doman xephem.1 tools/*/*.1
	mv tools .. # do not install tool sources into share directory
	for i in $(find . -type d -mindepth 1); do
		insinto /usr/share/${PN}/${i}
		doins ${i}/*
	done

	echo > ${S}/XEphem "XEphem.ShareDir: /usr/share/${PN}"
	insinto /usr/lib/X11/app-defaults/
	doins ${S}/XEphem

	cd ${S}
	dodoc Copyright README INSTALL
}
