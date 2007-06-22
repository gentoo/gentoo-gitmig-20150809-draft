# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/bigloo/bigloo-2.7a_p2.ebuild,v 1.5 2007/06/22 10:59:55 hkbst Exp $

inherit elisp-common

MY_P=${PN}${PV/_p/-r}

DESCRIPTION="Bigloo is a Scheme implementation."
HOMEPAGE="http://www-sop.inria.fr/mimosa/fp/Bigloo/bigloo.html"
SRC_URI="ftp://ftp-sop.inria.fr/mimosa/fp/Bigloo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="java emacs"

DEPEND=">=sys-apps/sed-4
	emacs? ( virtual/emacs )
	java? ( virtual/jdk app-arch/zip )"

S=${WORKDIR}/${MY_P}

SITEFILE="50bigloo-gentoo.el"

src_compile() {
	local myconf="--dotnet=no --lispdir=/usr/share/emacs/site-lisp/bigloo --tmpdir=/tmp"
	local myjava=`java-config --java`
	local myjavac=`java-config --javac`

	use java &&
		myconf="$myconf --jvm=force --java=$myjava --javac=$myjavac" \
		|| myconf="$myconf --jvm=no"

	./configure \
		--native=yes \
		--cflags="${CFLAGS} -fno-reorder-blocks" \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man/man1 \
		--docdir=/usr/share/doc/${PF} \
		--tmp=/tmp \
		$myconf || die "./configure failed"

	echo LD_LIBRARY_PATH=${S}/lib/${PV} >> Makefile.config

	sed -i "s/JCFLAGS=-O/JCFLAGS=/" Makefile.config || die
	sed -i "s/\$(BOOTBINDIR)\/afile jas/LD_LIBRARY_PATH=\$(LD_LIBRARY_PATH) \$(BOOTBINDIR)\/afile jas/" \
		bde/Makefile || die

	make || die

	if use emacs; then
		pushd etc; elisp-comp *.el; popd
	fi
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/doc/${PF}
	dodir /usr/share/man/man1
	dodir /usr/share/info

	dodir /etc/env.d
	echo "LDPATH=/usr/lib/bigloo/${PV}/" \
		> ${D}/etc/env.d/25bigloo
	make DESTDIR=${D} install || die

	if use emacs; then
		elisp-install bigloo etc/*.{el,elc}
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi

}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
