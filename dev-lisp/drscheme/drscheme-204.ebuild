# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/drscheme/drscheme-204.ebuild,v 1.1 2003/05/26 13:47:16 darkspecter Exp $

S=${WORKDIR}/plt
DESCRIPTION="DrScheme programming environment.  Includes mzscheme."
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"
SRC_URI="http://download.plt-scheme.org/bundles/${PV}/plt/plt.src.x.tar.gz"
DEPEND=">=sys-devel/gcc-2.95.3-r7
	virtual/x11
	opengl? ( virtual/opengl )"
RDEPEND="virtual/x11
	opengl? ( virtual/opengl )"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_compile() {
	cd ${S}/src

	econf \
		--prefix=/usr/share/drscheme/

	make || die
}

mysed() {
	file=${D}/$1
	mv ${file} ${file}.orig
	sed s.${D}./. < ${file}.orig> ${file}
	chmod a+x ${file}
	rm ${file}.orig
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

	for x in background-help-desk drscheme games help-desk mzc \
		setup-plt tex2page web-server web-server-monitor \
		web-server-text
	do
		mysed /usr/share/drscheme/bin/${x}
	done

	cd ${D}/usr/share/drscheme/bin
	for x in *
	do
		dosym /usr/share/drscheme/bin/${file} /usr/bin/${file}
	done
}
