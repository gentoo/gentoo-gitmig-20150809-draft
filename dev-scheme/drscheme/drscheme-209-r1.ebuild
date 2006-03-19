# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/drscheme/drscheme-209-r1.ebuild,v 1.1 2006/03/19 02:09:47 chutzpah Exp $

DESCRIPTION="DrScheme programming environment.  Includes mzscheme."
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"
SRC_URI="http://download.plt-scheme.org/bundles/${PV}/plt/plt-${PV}-src-unix.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl"
S=${WORKDIR}/plt

src_compile() {
	cd ${S}/src

	econf \
		--prefix=/usr/share/drscheme/ || die "econf failed"

	make || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/drscheme

	cd ${S}/src
	sed -e 's/cp -p/cp/' Makefile > Makefile.new
	mv Makefile.new Makefile
	echo -e "n\n" | make prefix=${D}/usr/share/drscheme install || die
	dodoc README
	cd ${D}/usr/share/drscheme/man/man1
	doman *
	rm -rf ${D}/usr/share/drscheme/man

	MY_D="${D%/}"
	MY_D="${MY_D//\//\/}"

	cd "${D}/usr/share/drscheme/bin"

	for x in background-help-desk drscheme games help-desk mzc \
		setup-plt tex2page web-server web-server-monitor \
		web-server-text
	do
		if [ -e "${x}" ]; then
			sed -i "s/${MY_D}//g" "${x}"
			sed -i "s/${MY_D#\\/var}//g" "${x}"
			echo sed -i "s/${MY_D}//g" "${x}"
			echo sed -i "s/${MY_D#\\/var}//g" "${x}"
			grep -q portage/ "$x" && die
		fi
	done

	for x in *
	do
		dosym /usr/share/drscheme/bin/${x} /usr/bin/${x}
	done
}
