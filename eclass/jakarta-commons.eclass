# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/jakarta-commons.eclass,v 1.5 2003/05/15 18:52:51 absinthe Exp $

inherit base java-pkg
ECLASS=jakarta-commons
INHERITED="$INHERITED $ECLASS"
IUSE="$IUSE"

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://jakarta.apache.org/"

# deps on the build tools
DEPEND="$DEPEND
        >=virtual/jdk-1.3
        >=ant-1.4
        log4j? ( >=dev-java/log4j-1.2 )
        junit? ( >=dev-java/junit-3.7 )"

RDEPEND="$RDEPEND >=virtual/jdk-1.3"
SLOT="$SLOT"

#jakarta-commons_src_unpack() {
#
#	debug-print-function $FUNCNAME $*
#	
#	# call base_src_unpack, which implements most of the functionality and has sections,
#	# unlike this function. The change from base_src_unpack to kde_src_unpack is thus
#	# wholly transparent for ebuilds.
#	base_src_unpack $*
#	
#	cd ${S}
#	debug-print "$FUNCNAME: Unpacked to $PWD"
#}

jakarta-commons_src_compile() {

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && jakarta-commons_src_compile all
    ant_targetlist=`fgrep "<target" build.xml | sed -e 's/.*name="\([^"]*\)".*/\1/g'`
    debug-print "TargetList: $ant_targetlist"

	cd ${S}
	while [ "$1" ]; do
		case $1 in
			myconf)
				debug-print-section myconf
				use jikes && myconf="$myconf -Dbuild.compiler=jikes"
				use log4j && echo "log4j.jar=`java-config --classpath=log4j`" >> build.properties
				use junit && echo "junit.jar=`java-config --classpath=junit`" >> build.properties
				debug-print "$FUNCNAME: myconf: set to ${myconf}"
				;;
            		maketest)
				debug-print-section maketest
                		if [ -n "`use junit`" ]; then
                    			if [ -n $(echo "$target" | grep "test") ]; then
                        			ANT_OPTS=${myconf} ant test || die "Building Testing Classes Failed"
                    			else
                        			ANT_OPTS=${myconf} ant || die "Building Testing Classes Failed"
                    			fi
                		fi
                		;;
			make)
				debug-print-section make
						for each in $ant_targetlist
						do
							if [ "${each}" == "jar" ] ; then
								target=${each}
							elif [ "${each}" == "dist-jar" ] ; then
								target=${each}
							elif [ "${each}" == "compile" ] ; then
								target=${each}
							fi
						done
                		ANT_OPTS=${myconf} ant ${target} || die "Compilation Failed"
				;;
			makedoc)
				debug-print-section makedoc
				ANT_OPTS="${myconf}"
                		target=`echo "${ant_targetlist}" | grep "^javadoc$"`
                		debug-print "Building ${target}"
                		if [ -n "${target}" ]; then
                    			ant "${target}" || die "Unable to create documents"
                		else
                  			target=`echo "${ant_targetlist}" | grep "^doc$"`
                  			if [ -n "${target}" ]; then
                    				ant "${target}" || die "Unable to create documents"
                  			fi
                		fi
				;;
			all)
				debug-print-section all
                # Problem in commons-logging
				jakarta-commons_src_compile myconf make makedoc
				;;
		esac

	shift
	done
}

jakarta-commons_src_install() {

	debug-print-function $FUNCNAME $*
	[ -z "$1" ] && jakarta-commons_src_install all

	cd ${S}
	while [ "$1" ]; do

		case $1 in
		dojar)
				debug-print-section dojar
				[ -d dist/ ] && java-pkg_dojar dist/*.jar
				[ -d target/ ] && java-pkg_dojar target/*.jar
				;;
	    	dohtml)
				debug-print-section dohtml
				[ -f LICENSE.txt ] && dodoc LICENSE.txt
				[ -f RELEASE-NOTES.txt ] && dodoc RELEASE-NOTES.txt
				[ -n $(ls -1 *.html 2> /dev/null | wc -l ) ] && dohtml *.html
				[ -n $(ls -1 dist/*.html 2> /dev/null | wc -l ) ] && dohtml dist/*.html
				[ -n $(ls -1 dist/docs/* 2> /dev/null | wc -l ) ] && dohtml -r dist/docs/*
				;;
	    	all)
				debug-print-section all
				jakarta-commons_src_install dojar dohtml
				;;
		esac

	shift
	done
}

EXPORT_FUNCTIONS src_compile src_install
