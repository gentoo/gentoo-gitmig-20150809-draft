# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/tmda/tmda-1.1.12.ebuild,v 1.1 2010/01/07 14:37:24 patrick Exp $

inherit eutils

DESCRIPTION="Python-based SPAM reduction system"
HOMEPAGE="http://www.tmda.net/"
LICENSE="GPL-2"

DEPEND=">=dev-lang/python-2.2
	virtual/mta"

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_compile () {
	# Do not open /dev/tty when in batch mode. (bug #67150) -ticho
	epatch ${FILESDIR}/tmda-1.0-non-interactive-tty.patch

	./compileall || die "tmda compilation failed"
}

src_install () {
	# Figure out python version
	# below hack should be replaced w/ pkg-config, when we get it working
	local pv=`python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:'`

	# Executables
	dobin bin/tmda-*

	# The Python TMDA module
	insinto "/usr/lib/python${pv}/site-packages/TMDA"
	doins TMDA/*.py*
	insinto "/usr/lib/python${pv}/site-packages/TMDA/Queue"
	doins TMDA/Queue/*.py*
	insinto "/usr/lib/python${pv}/site-packages/TMDA/pythonlib/email"
	doins TMDA/pythonlib/email/*.py*
	insinto "/usr/lib/python${pv}/site-packages/TMDA/pythonlib/email/mime"
	doins TMDA/pythonlib/email/mime/*.py*

	# The templates
	insinto /etc/tmda
	doins templates/*.txt

	# Documentation
	dodoc COPYING ChangeLog README THANKS UPGRADE CRYPTO CODENAMES INSTALL
	dohtml -r htdocs/*.html
	dohtml -r htdocs/img

	# Contributed binaries and stuff
	cd ${S}/contrib

	exeinto /usr/lib/tmda/contrib
	doexe collectaddys def2html printcdb printdbm \
	      sendit.sh smtp-check-sender update-internaldomains vadduser-tmda \
	      vmailmgr-vdir.sh vpopmail-vdir.sh wrapfd3.sh

	insinto /usr/lib/tmda/contrib
	doins ChangeLog tmda.el tmda.spec \
	      tofmipd.init tofmipd.sysconfig vtmdarc

	insinto /usr/lib/tmda/contrib/dot-tmda
	doins dot-tmda/*
}
