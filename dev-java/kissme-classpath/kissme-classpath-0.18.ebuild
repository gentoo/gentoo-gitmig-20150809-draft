# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/kissme-classpath/kissme-classpath-0.18.ebuild,v 1.1 2001/09/27 21:41:16 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="This is a sample skeleton ebuild file"

SRC_URI="http://prdownloads.sourceforge.net/kissme/kissme-classpath-0.18.tar.gz"

HOMEPAGE="http://www.gnu.org/software/classpath/classpath.html"

DEPEND=">=dev-java/blackdown-sdk-1.3.1
        >=dev-java/jikes-1.13
        app-shells/zsh"

src_compile() {
    make build || die
}

src_install () {
    dodir usr/share/kissme/classpath
    dodoc src/README
    DESTDIR=${D} sh install.sh || die
}

