# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.6.1.ebuild,v 1.6 2004/01/05 23:27:21 robbat2 Exp $

S="${WORKDIR}/Zope-${PV}-src"

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites."
HOMEPAGE="http://www.zope.org"
SRC_URI="http://www.zope.org/Products/Zope/${PV}/Zope-${PV}-src.tgz"
LICENSE="ZPL"
SLOT="0"

KEYWORDS="x86 ~sparc"

# This is for developers that wish to test Zope with virtual/python.
# If this is a problem, let me know right away. --kutsuya@gentoo.org
# I wondering if we need a USE flag for this. But I'm planning to have
# a private environmental variable called PYTHON_SLOT_VERSION set in
# ebuilds to build extensions for python2.1.

if [ "${PYTHON_SLOT_VERSION}" = 'VIRTUAL' ] ; then
	RDEPEND="virtual/python"
	python='python'
else
	RDEPEND="=dev-lang/python-2.1.3*"
	python='python2.1'
fi

DEPEND="virtual/glibc
		>=sys-apps/sed-4.0.5
	   ${RDEPEND}"

RDEPEND="app-admin/zope-config
	${RDEPEND}"

ZUID=zope
ZGID=$(echo ${P} |sed -e "s:\.:_:g")
ZS_DIR=${ROOT}/usr/share/zope/
ZI_DIR=${ROOT}/var/lib/zope/
ZSERVDIR=${ZS_DIR}/${PF}/
ZINSTDIR=${ZI_DIR}/${ZGID}
CONFDIR=${ROOT}/etc/conf.d/
RCNAME=zope.initd

# Narrow the scope of ownership/permissions.
# Security plan:
# * ZUID is the superuser for all zope instances.
# * ZGID is for a single instance's administration.
# * Other's should not have any access to ${ZSERVDIR},
#   because they can work through the Zope web interface.
#   This should protect our code/data better.

#Parameters:
# $1 = instance directory
# $2 = group

setup_security()
{
	chown -R ${ZUID}:${2} ${1}
	chmod -R g+u ${1}
	chmod -R o-rwx ${1}
}

#

install_help()
{
	einfo "Need to setup an inituser (admin) before executing zope:"
	einfo "\tzope-config --zpasswd"
	einfo "To execute default Zope instance:"
	einfo "\t/etc/init.d/${ZGID} start"
}

#

pkg_setup()
{
	if [ "${PYTHON_SLOT_VERSION}" = 'VIRTUAL' ] ; then
		ewarn "WARNING: You set PYTHON_SLOT_VERSION=VIRTUAL. So this ebuild will"
		ewarn "use python-2.2*. Zope Corp. only recommends using python-2.1.3 "
		ewarn "with this version of zope. Emerge at your own risk."
		sleep 12
	fi
	if ! groupmod ${ZGID} > /dev/null 2>&1 ; then
		groupadd ${ZGID} || die "Can not add ${ZGID} group!"
	fi
	if ! id ${ZUID} > /dev/null 2>&1 ; then
		useradd -d ${ZS_DIR} -c "Zope root user" -u 261 ${ZUID} \
	|| die "Can not add ${ZUID} user!"
	fi
}

#

src_compile() {
	$python wo_pcgi.py || die "Failed to compile."
}

#

src_install() {
	dodoc LICENSE.txt README.txt
	docinto doc ; dodoc doc/*.txt
	docinto doc/PLATFORMS ; dodoc doc/PLATFORMS/*
	docinto doc/changenotes ; dodoc doc/changenotes/*

	# using '/etc/init.d/zope'
	rm -Rf start stop LICENSE.txt README.txt doc/

	# Need to rip out the zinstance stuff out
	# but save as templates
	mkdir -p .templates/import
	cp import/README.txt .templates/import/
	mv -f Extensions/ .templates/
	mv -f var/ .templates/

	# Add conf.d script.
	dodir /etc/conf.d
	echo "ZOPE_OPTS=\"-u zope\"" | \
	cat - ${FILESDIR}/${PV}/zope.envd > .templates/zope.confd

	# Fill in environmental variables
	sed -i -e "/ZOPE_HOME=/ c\\ZOPE_HOME=${ZSERVDIR}\\ " \
		-e "/SOFTWARE_HOME=/ c\\SOFTWARE_HOME=${ZSERVDIR}/lib/python\\ " \
		.templates/zope.confd

	# Add rc-script.
	#!! TODO: fill in $python in zope-r2.initd
	sed -e "/python=/ c\\python=\"${python}\"\\ " ${FILESDIR}/${PV}/${RCNAME} \
		> .templates/zope.initd

	# Copy the remaining contents of ${S} into the ${D}.
	dodir ${ZSERVDIR}
	cp -a . ${D}${ZSERVDIR}

	setup_security ${D}${ZSERVDIR} ${ZGID}
}

#

pkg_postinst()
{
	# Here we add our default zope instance.
	/usr/sbin/zope-config --zserv=${ZSERVDIR} --zinst=${ZINSTDIR} \
		--zgid=${ZGID}
	install_help
}

#

pkg_postrm()
{
	# rcscripts and conf.d files will remain. i.e. /etc protection.

	# Delete .default if this ebuild is the default. zprod-manager will
	# have to handle a missing default;
	local VERSION_DEF="$(zope-config --zidef-get)"
	if [ "${ZGID}" = "$VERSION_DEF" ] ; then
		rm -f ${ZI_DIR}/.default
	fi
}

#

pkg_config()
{
	install_help
}
