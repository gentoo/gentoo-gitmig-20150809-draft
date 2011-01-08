# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pygresql/pygresql-3.8.1.ebuild,v 1.9 2011/01/08 16:08:43 arfrever Exp $

EAPI="3"

inherit eutils distutils

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"

MY_P="PyGreSQL-${PV}"

DESCRIPTION="A Python interface for the PostgreSQL database."
SRC_URI="ftp://ftp.pygresql.org/pub/distrib/${MY_P}.tgz"
HOMEPAGE="http://www.pygresql.org/"
LICENSE="as-is"
SLOT="0"
IUSE="doc"

DEPEND="dev-db/postgresql-base"
RDEPEND="${DEPEND}
		dev-python/egenix-mx-base"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install

	dodoc docs/*.txt

	if use doc ; then
		insinto /usr/share/doc/${PF}/tutorial
		doins tutorial/*
		dohtml docs/*.{html,css}
	fi
}
