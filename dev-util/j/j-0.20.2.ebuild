# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/j/j-0.20.2.ebuild,v 1.1 2004/02/15 01:57:51 zx Exp $

IUSE=""
SRC_URI="mirror://sourceforge/armedbear-${PN}/${P}.tar.gz"

DESCRIPTION="Programmer's text editor written in Java, includes Armed Bear Lisp."
HOMEPAGE="http://armedbear-j.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}/${P}

src_compile() {
	if [ -n "$(java-config --jdk-home)" ]; then
		econf \
			--with-jdk="$(java-config --jdk-home)" \
			$(if [ -f "/usr/share/xerces/lib/xercesImpl.jar" ]; then echo "--with-extensions=/usr/share/xerces/lib/xercesImpl.jar"; fi) \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man \
			|| die "./configure failed"
	else
		eerror "You must have a system default JDK to compile this package !!!"
		einfo "Use 'java-config --list-available-vms' to find the name of your installed JDK."
		einfo "Then use 'java-config --set-system-vm=<JDK name>' to make it the system default."
		die "./configure failed: No JDK"
	fi
	emake || die
}

src_install() {
	einstall || die
}
