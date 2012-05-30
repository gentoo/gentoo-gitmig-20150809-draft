# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-celery/django-celery-2.5.5.ebuild,v 1.1 2012/05/30 06:48:04 iksaif Exp $

EAPI="4"
PYTHON_COMPAT="python2_7"

inherit python-distutils-ng

DESCRIPTION="Celery Integration for Django"
HOMEPAGE="http://celeryproject.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/django-picklefield-0.2.0
	>=dev-python/celery-2.5.1
	>=dev-python/django-1.3"

DEPEND="${RDEPEND}
	dev-python/setuptools"

python_test() {
	${PYTHON} setup.py test
}
